// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VRCBCE/Surface Color Mask (Fur)"
{
	Properties
	{
		_Turnoff("Turn off", Range( 0 , 1)) = 0
		_MainTex("Main Tex", 2D) = "white" {}
		_BallColour("Ball Colour", Color) = (1,0,0,0)
		_CustomColor("Custom Color", Range( -1 , 0)) = -1
		_ColourMask("Colour Mask", 2D) = "black" {}
		_ConstMask("Const Mask", 2D) = "black" {}
		_emissionmap("emission map", 2D) = "white" {}
		_Emission("Emission", Color) = (0,0,0,0)
		_normalmap("normal map", 2D) = "bump" {}
		_metalic("metalic", 2D) = "black" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_FurAmount("FurAmount", Range( 0 , 1)) = 0
		_FurNoise("Fur Noise", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		
		
		
		struct Input
		{
			float2 uv_texcoord;
		};
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Turnoff;
		uniform sampler2D _ConstMask;
		uniform float4 _ConstMask_ST;
		uniform sampler2D _ColourMask;
		uniform float4 _ColourMask_ST;
		uniform float _CustomColor;
		uniform float4 _BallColour;
		uniform float _FurAmount;
		uniform sampler2D _FurNoise;
		uniform float4 _FurNoise_ST;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float temp_output_69_0 = ( _FurAmount / 100.0 );
			float2 uv_FurNoise = v.texcoord * _FurNoise_ST.xy + _FurNoise_ST.zw;
			float4 temp_output_60_0 = ( temp_output_69_0 * tex2Dlod( _FurNoise, float4( uv_FurNoise, 0, 0.0) ) );
			float outlineVar = temp_output_60_0.r;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float2 uv_ConstMask = i.uv_texcoord * _ConstMask_ST.xy + _ConstMask_ST.zw;
			float4 tex2DNode27 = tex2D( _ConstMask, uv_ConstMask );
			float2 uv_ColourMask = i.uv_texcoord * _ColourMask_ST.xy + _ColourMask_ST.zw;
			float4 tex2DNode26 = tex2D( _ColourMask, uv_ColourMask );
			float temp_output_18_0 = abs( _CustomColor );
			float4 temp_cast_0 = (temp_output_18_0).xxxx;
			float4 clampResult20 = clamp( ( tex2DNode1 - ( tex2DNode26 - temp_cast_0 ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 abledocolor62 = ( ( tex2DNode1 * _Turnoff ) + ( ( ( ( 1.0 - tex2DNode27 ) * ( clampResult20 + ( ( 1.0 - temp_output_18_0 ) * ( tex2DNode26 * _BallColour ) ) ) ) + ( tex2DNode27 * tex2DNode1 ) ) * ( 1.0 - _Turnoff ) ) );
			o.Emission = abledocolor62.rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _normalmap;
		uniform float4 _normalmap_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Turnoff;
		uniform sampler2D _ConstMask;
		uniform float4 _ConstMask_ST;
		uniform sampler2D _ColourMask;
		uniform float4 _ColourMask_ST;
		uniform float _CustomColor;
		uniform float4 _BallColour;
		uniform sampler2D _emissionmap;
		uniform float4 _emissionmap_ST;
		uniform float4 _Emission;
		uniform sampler2D _metalic;
		uniform float4 _metalic_ST;
		uniform float _Smoothness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_output_61_0 = 0;
			v.vertex.xyz += temp_output_61_0;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_normalmap = i.uv_texcoord * _normalmap_ST.xy + _normalmap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _normalmap, uv_normalmap ) );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float2 uv_ConstMask = i.uv_texcoord * _ConstMask_ST.xy + _ConstMask_ST.zw;
			float4 tex2DNode27 = tex2D( _ConstMask, uv_ConstMask );
			float2 uv_ColourMask = i.uv_texcoord * _ColourMask_ST.xy + _ColourMask_ST.zw;
			float4 tex2DNode26 = tex2D( _ColourMask, uv_ColourMask );
			float temp_output_18_0 = abs( _CustomColor );
			float4 temp_cast_0 = (temp_output_18_0).xxxx;
			float4 clampResult20 = clamp( ( tex2DNode1 - ( tex2DNode26 - temp_cast_0 ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 abledocolor62 = ( ( tex2DNode1 * _Turnoff ) + ( ( ( ( 1.0 - tex2DNode27 ) * ( clampResult20 + ( ( 1.0 - temp_output_18_0 ) * ( tex2DNode26 * _BallColour ) ) ) ) + ( tex2DNode27 * tex2DNode1 ) ) * ( 1.0 - _Turnoff ) ) );
			o.Albedo = abledocolor62.rgb;
			float2 uv_emissionmap = i.uv_texcoord * _emissionmap_ST.xy + _emissionmap_ST.zw;
			o.Emission = ( tex2D( _emissionmap, uv_emissionmap ) * _Emission ).rgb;
			float2 uv_metalic = i.uv_texcoord * _metalic_ST.xy + _metalic_ST.zw;
			o.Metallic = tex2D( _metalic, uv_metalic ).r;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18912
698;418;1287;546;2884.369;873.5447;3.750504;True;True
Node;AmplifyShaderEditor.CommentaryNode;45;-1271.381,-884.7063;Inherit;False;1055.037;908.3127;Diffuse Color Masked;22;34;33;17;20;24;25;2;7;11;18;4;26;10;1;32;30;27;52;53;54;56;57;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1258.248,-455.4345;Inherit;False;Property;_CustomColor;Custom Color;3;0;Create;True;0;0;0;False;0;False;-1;-1;-1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;-1259.803,-359.3143;Inherit;True;Property;_ColourMask;Colour Mask;4;0;Create;True;0;0;0;False;0;False;-1;None;dae4702bfb257a843ad895df7a1bc312;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;18;-989.0374,-452.6715;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-1267.84,-170.7831;Inherit;False;Property;_BallColour;Ball Colour;2;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;11;-966.1204,-373.1326;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-1296.086,-651.0627;Inherit;True;Property;_MainTex;Main Tex;1;0;Create;True;0;0;0;False;0;False;-1;None;69f2be7b2ff862b4db4505b849ba104d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-966.7111,-262.7997;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;25;-847.3535,-457.7182;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-901.7258,-579.3096;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-811.9778,-320.3777;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;27;-1258.996,-836.7474;Inherit;True;Property;_ConstMask;Const Mask;5;0;Create;True;0;0;0;False;0;False;-1;None;80be9b23c0cef4549aafbd60c9dd892e;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;20;-706.9584,-580.012;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-533.8355,-555.7209;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;32;-918.0083,-828.3593;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-957.1634,-734.7239;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-485.3527,-819.9461;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-874.3599,-672.2092;Inherit;False;Property;_Turnoff;Turn off;0;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-344.9158,-738.6783;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;56;-616.4469,-688.3282;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-418.1759,-643.193;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-403.6664,-512.6248;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-400.4442,-372.3839;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-854.5571,774.3701;Inherit;False;Property;_FurAmount;FurAmount;11;0;Create;True;0;0;0;False;0;False;0;0.77;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-807.2518,872.3019;Inherit;False;Constant;_Float2;Float 2;13;0;Create;True;0;0;0;False;0;False;100;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;69;-538.0431,773.0087;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-226.406,-284.1791;Inherit;False;abledocolor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;59;-567.6094,912.3091;Inherit;True;Property;_FurNoise;Fur Noise;12;0;Create;True;0;0;0;False;0;False;-1;None;567493b9d05139c45a9c4ed0308d978d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;48;-351.1249,138.646;Inherit;True;Property;_emissionmap;emission map;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;63;-164.0764,660.5453;Inherit;False;62;abledocolor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;39;-516.1504,304.437;Inherit;False;Property;_Emission;Emission;7;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-184.8601,842.1999;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-262.5736,585.494;Inherit;False;Property;_Smoothness;Smoothness;10;0;Create;True;0;0;0;False;0;False;0;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;195.4754,624.4541;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-345.2625,673.0318;Inherit;False;Constant;_two;two;13;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;68;-37.06262,780.9314;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;65;-175.0626,743.9314;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-781.9532,44.04107;Inherit;True;Property;_normalmap;normal map;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-40.50067,162.0663;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;61;143.0598,774.3185;Inherit;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;44;-283.198,360.3603;Inherit;True;Property;_metalic;metalic;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;120.4839,59.60097;Float;False;True;-1;2;;0;0;Standard;VRCBCE/Surface Color Mask (Fur);False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;18;0;10;0
WireConnection;11;0;26;0
WireConnection;11;1;18;0
WireConnection;7;0;26;0
WireConnection;7;1;2;0
WireConnection;25;0;18;0
WireConnection;4;0;1;0
WireConnection;4;1;11;0
WireConnection;24;0;25;0
WireConnection;24;1;7;0
WireConnection;20;0;4;0
WireConnection;17;0;20;0
WireConnection;17;1;24;0
WireConnection;32;0;27;0
WireConnection;30;0;27;0
WireConnection;30;1;1;0
WireConnection;33;0;32;0
WireConnection;33;1;17;0
WireConnection;34;0;33;0
WireConnection;34;1;30;0
WireConnection;56;0;53;0
WireConnection;54;0;34;0
WireConnection;54;1;56;0
WireConnection;52;0;1;0
WireConnection;52;1;53;0
WireConnection;57;0;52;0
WireConnection;57;1;54;0
WireConnection;69;0;58;0
WireConnection;69;1;70;0
WireConnection;62;0;57;0
WireConnection;60;0;69;0
WireConnection;60;1;59;0
WireConnection;64;1;61;0
WireConnection;68;0;60;0
WireConnection;68;1;65;0
WireConnection;65;0;69;0
WireConnection;65;1;67;0
WireConnection;49;0;48;0
WireConnection;49;1;39;0
WireConnection;61;0;63;0
WireConnection;61;1;60;0
WireConnection;0;0;62;0
WireConnection;0;1;40;0
WireConnection;0;2;49;0
WireConnection;0;3;44;0
WireConnection;0;4;51;0
WireConnection;0;11;61;0
ASEEND*/
//CHKSM=EFB2F83DC6179972265E49C1C95073A9304B563F