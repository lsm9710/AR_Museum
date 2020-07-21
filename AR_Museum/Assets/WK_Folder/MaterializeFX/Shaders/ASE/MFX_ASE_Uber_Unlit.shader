// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "QFX/MFX/ASE/Uber/Unlit"
{
	Properties
	{
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionMap("Emission Texture", 2D) = "white" {}
		[HDR]_FringeEmissionColor("Fringe Emission Color", Color) = (0,0,0,1)
		[HDR]_EmissionColor2("Emission Color 2", Color) = (1,1,1,1)
		_EmissionMap2("Emission Texture 2", 2D) = "white" {}
		_EmissionMap2_Scroll("Emission Texture 2 Scroll", Vector) = (0,0,0,0)
		_EmissionSize2("Emission Size 2", Range( 0 , 1)) = 0.32633
		[Toggle]_EmissionSmooth2("EmissionSmooth2?", Float) = 1
		[HDR]_EdgeColor("Edge Color", Color) = (1,1,1,1)
		_EdgeRampMap1("Edge Ramp Map", 2D) = "white" {}
		_EdgeRampMap1_Scroll("Edge Ramp Map Scroll", Vector) = (0,0,0,0)
		_FringeEmissionMap_Scroll("FringeEmissionMap Scroll", Vector) = (0,0,0,0)
		_FringeRampMap_Scroll("Fringe Ramp Map Scroll", Vector) = (0,0,0,0)
		_EdgeSize("Edge Size", Range( 0 , 2)) = 0.5
		_DissolveMap1("Dissolve Map", 2D) = "white" {}
		_DissolveMap1_Scroll("Dissolve Map Scroll", Vector) = (0,0,0,0)
		_DissolveSize("Dissolve Size", Range( 0 , 5)) = 2
		[HDR]_DissolveEdgeColor("Dissolve Edge Color", Color) = (1,1,1,1)
		_DissolveEdgeSize("Dissolve Edge Size", Range( 0 , 2)) = 0
		_FringeEmissionMap("Fringe Emission Map", 2D) = "white" {}
		_FringeRampMap("Fringe Ramp Map", 2D) = "white" {}
		_FringeSize("Fringe Size", Float) = 0
		_FringeOffset("Fringe Offset", Float) = 0
		_FringeAmount("Fringe Amount", Float) = 0
		_MaskOffset("Mask Offset", Float) = 1.04
		[Toggle]_Invert("Invert", Float) = 0
		[KeywordEnum(None,AxisLocal,AxisGlobal,Global)] _MaskType("Mask Type", Float) = 2
		[KeywordEnum(X,Y,Z)] _CutoffAxis("Cutoff Axis", Float) = 1
		_WorldPositionOffset("World Position Offset", Vector) = (0,0,0,0)
		_MaskWorldPosition("Mask World Position", Vector) = (0,0,0,0)
		_Cutoff( "Mask Clip Value", Float ) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _CUTOFFAXIS_X _CUTOFFAXIS_Y _CUTOFFAXIS_Z
		#pragma shader_feature _MASKTYPE_NONE _MASKTYPE_AXISLOCAL _MASKTYPE_AXISGLOBAL _MASKTYPE_GLOBAL
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _FringeRampMap;
		uniform float2 _FringeRampMap_Scroll;
		uniform float4 _FringeRampMap_ST;
		uniform float _FringeAmount;
		uniform float _FringeSize;
		uniform float _FringeOffset;
		uniform float3 _WorldPositionOffset;
		uniform float3 _MaskWorldPosition;
		uniform float _Invert;
		uniform float _MaskOffset;
		uniform sampler2D _EdgeRampMap1;
		uniform float2 _EdgeRampMap1_Scroll;
		uniform float4 _EdgeRampMap1_ST;
		uniform float _EdgeSize;
		uniform float _DissolveSize;
		uniform sampler2D _DissolveMap1;
		uniform float2 _DissolveMap1_Scroll;
		uniform float4 _DissolveMap1_ST;
		uniform float _DissolveEdgeSize;
		uniform float4 _DissolveEdgeColor;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float _EmissionSmooth2;
		uniform float4 _EmissionColor2;
		uniform sampler2D _EmissionMap2;
		uniform float2 _EmissionMap2_Scroll;
		uniform float4 _EmissionMap2_ST;
		uniform float _EmissionSize2;
		uniform float4 _EdgeColor;
		uniform sampler2D _FringeEmissionMap;
		uniform float2 _FringeEmissionMap_Scroll;
		uniform float4 _FringeEmissionMap_ST;
		uniform float4 _FringeEmissionColor;
		uniform float _Cutoff = 0.1;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_FringeRampMap = v.texcoord.xy * _FringeRampMap_ST.xy + _FringeRampMap_ST.zw;
			float2 panner57_g1 = ( 1.0 * _Time.y * _FringeRampMap_Scroll + uv_FringeRampMap);
			float4 tex2DNode68_g1 = tex2Dlod( _FringeRampMap, float4( panner57_g1, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			float temp_output_87_0_g1 = ( 1.0 - _FringeSize );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_4_0_g1 = ( ase_worldPos - _WorldPositionOffset );
			float3 temp_cast_0 = (1.0).xxx;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 temp_cast_1 = (length( ( temp_output_4_0_g1 - _MaskWorldPosition ) )).xxx;
			#if defined(_MASKTYPE_NONE)
				float3 staticSwitch10_g1 = temp_cast_0;
			#elif defined(_MASKTYPE_AXISLOCAL)
				float3 staticSwitch10_g1 = ase_vertex3Pos;
			#elif defined(_MASKTYPE_AXISGLOBAL)
				float3 staticSwitch10_g1 = temp_output_4_0_g1;
			#elif defined(_MASKTYPE_GLOBAL)
				float3 staticSwitch10_g1 = temp_cast_1;
			#else
				float3 staticSwitch10_g1 = temp_output_4_0_g1;
			#endif
			float3 break13_g1 = staticSwitch10_g1;
			#if defined(_CUTOFFAXIS_X)
				float staticSwitch20_g1 = break13_g1.x;
			#elif defined(_CUTOFFAXIS_Y)
				float staticSwitch20_g1 = break13_g1.y;
			#elif defined(_CUTOFFAXIS_Z)
				float staticSwitch20_g1 = break13_g1.z;
			#else
				float staticSwitch20_g1 = break13_g1.y;
			#endif
			float mfx_pos25_g1 = staticSwitch20_g1;
			float mfx_invert_option23_g1 = lerp(1.0,-1.0,_Invert);
			float temp_output_28_0_g1 = ( mfx_invert_option23_g1 * _MaskOffset );
			float mfx_mask_pos40_g1 = ( ( mfx_pos25_g1 * mfx_invert_option23_g1 ) - temp_output_28_0_g1 );
			float mfx_mask_offset38_g1 = temp_output_28_0_g1;
			float temp_output_78_0_g1 = ( ( _FringeOffset + ( mfx_mask_pos40_g1 - mfx_mask_offset38_g1 ) ) - tex2DNode68_g1.r );
			float smoothstepResult110_g1 = smoothstep( temp_output_87_0_g1 , ( temp_output_87_0_g1 + 0.1 ) , ( 1.0 - abs( temp_output_78_0_g1 ) ));
			float2 uv_EdgeRampMap1 = v.texcoord.xy * _EdgeRampMap1_ST.xy + _EdgeRampMap1_ST.zw;
			float2 panner27_g1 = ( 1.0 * _Time.y * _EdgeRampMap1_Scroll + uv_EdgeRampMap1);
			float2 uv_TexCoord31_g1 = v.texcoord.xy + panner27_g1;
			float mfx_edge_pos55_g1 = ( mfx_mask_pos40_g1 - ( temp_output_28_0_g1 - tex2Dlod( _EdgeRampMap1, float4( uv_TexCoord31_g1, 0, 0.0) ).r ) );
			float temp_output_84_0_g1 = saturate( ( 1.0 - ceil( mfx_edge_pos55_g1 ) ) );
			float mfx_edge_threshold108_g1 = temp_output_84_0_g1;
			float temp_output_66_0_g1 = ( 1.0 - _EdgeSize );
			float smoothstepResult85_g1 = smoothstep( temp_output_66_0_g1 , ( temp_output_66_0_g1 + 0.1 ) , ( 1.0 - abs( mfx_edge_pos55_g1 ) ));
			float mfx_edge119_g1 = saturate( ( smoothstepResult85_g1 - temp_output_84_0_g1 ) );
			float mfx_fringe_threshold170_g1 = ( saturate( ( smoothstepResult110_g1 - saturate( ( 1.0 - ceil( temp_output_78_0_g1 ) ) ) ) ) * ( ( 1.0 - mfx_edge_threshold108_g1 ) - mfx_edge119_g1 ) );
			float3 mfx_local_vert_offset184_g1 = ( tex2DNode68_g1.r * ( ase_vertexNormal * _FringeAmount ) * mfx_fringe_threshold170_g1 );
			v.vertex.xyz += mfx_local_vert_offset184_g1;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_4_0_g1 = ( ase_worldPos - _WorldPositionOffset );
			float3 temp_cast_0 = (1.0).xxx;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 temp_cast_1 = (length( ( temp_output_4_0_g1 - _MaskWorldPosition ) )).xxx;
			#if defined(_MASKTYPE_NONE)
				float3 staticSwitch10_g1 = temp_cast_0;
			#elif defined(_MASKTYPE_AXISLOCAL)
				float3 staticSwitch10_g1 = ase_vertex3Pos;
			#elif defined(_MASKTYPE_AXISGLOBAL)
				float3 staticSwitch10_g1 = temp_output_4_0_g1;
			#elif defined(_MASKTYPE_GLOBAL)
				float3 staticSwitch10_g1 = temp_cast_1;
			#else
				float3 staticSwitch10_g1 = temp_output_4_0_g1;
			#endif
			float3 break13_g1 = staticSwitch10_g1;
			#if defined(_CUTOFFAXIS_X)
				float staticSwitch20_g1 = break13_g1.x;
			#elif defined(_CUTOFFAXIS_Y)
				float staticSwitch20_g1 = break13_g1.y;
			#elif defined(_CUTOFFAXIS_Z)
				float staticSwitch20_g1 = break13_g1.z;
			#else
				float staticSwitch20_g1 = break13_g1.y;
			#endif
			float mfx_pos25_g1 = staticSwitch20_g1;
			float mfx_invert_option23_g1 = lerp(1.0,-1.0,_Invert);
			float temp_output_28_0_g1 = ( mfx_invert_option23_g1 * _MaskOffset );
			float mfx_mask_pos40_g1 = ( ( mfx_pos25_g1 * mfx_invert_option23_g1 ) - temp_output_28_0_g1 );
			float2 uv_DissolveMap1 = i.uv_texcoord * _DissolveMap1_ST.xy + _DissolveMap1_ST.zw;
			float2 panner83_g1 = ( 1.0 * _Time.y * _DissolveMap1_Scroll + uv_DissolveMap1);
			float mfx_alpha141_g1 = ( _DissolveSize + ( mfx_mask_pos40_g1 - ( temp_output_28_0_g1 - tex2D( _DissolveMap1, panner83_g1 ).r ) ) );
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 uv_EmissionMap2 = i.uv_texcoord * _EmissionMap2_ST.xy + _EmissionMap2_ST.zw;
			float2 panner22_g1 = ( 1.0 * _Time.y * _EmissionMap2_Scroll + uv_EmissionMap2);
			float4 tex2DNode29_g1 = tex2D( _EmissionMap2, panner22_g1 );
			float clampResult53_g1 = clamp( ( ( ( 1.0 - tex2DNode29_g1.r ) - 0.5 ) * 3.0 ) , 0.0 , 1.0 );
			float mfx_mask_offset38_g1 = temp_output_28_0_g1;
			float4 mfx_emission_297_g1 = lerp(( _EmissionColor2 * tex2DNode29_g1.r ),( _EmissionColor2 * ( pow( clampResult53_g1 , 3.0 ) * saturate( ( ( mfx_mask_pos40_g1 - mfx_mask_offset38_g1 ) + (0.0 + (_EmissionSize2 - 0.0) * (3.0 - 0.0) / (1.0 - 0.0)) ) ) ) ),_EmissionSmooth2);
			float2 uv_EdgeRampMap1 = i.uv_texcoord * _EdgeRampMap1_ST.xy + _EdgeRampMap1_ST.zw;
			float2 panner27_g1 = ( 1.0 * _Time.y * _EdgeRampMap1_Scroll + uv_EdgeRampMap1);
			float2 uv_TexCoord31_g1 = i.uv_texcoord + panner27_g1;
			float mfx_edge_pos55_g1 = ( mfx_mask_pos40_g1 - ( temp_output_28_0_g1 - tex2D( _EdgeRampMap1, uv_TexCoord31_g1 ).r ) );
			float temp_output_84_0_g1 = saturate( ( 1.0 - ceil( mfx_edge_pos55_g1 ) ) );
			float mfx_edge_threshold108_g1 = temp_output_84_0_g1;
			float4 lerpResult113_g1 = lerp( ( _EmissionColor * tex2D( _EmissionMap, uv_EmissionMap ) ) , mfx_emission_297_g1 , mfx_edge_threshold108_g1);
			float4 mfx_emission129_g1 = lerpResult113_g1;
			float temp_output_66_0_g1 = ( 1.0 - _EdgeSize );
			float smoothstepResult85_g1 = smoothstep( temp_output_66_0_g1 , ( temp_output_66_0_g1 + 0.1 ) , ( 1.0 - abs( mfx_edge_pos55_g1 ) ));
			float mfx_edge119_g1 = saturate( ( smoothstepResult85_g1 - temp_output_84_0_g1 ) );
			float2 uv_FringeEmissionMap = i.uv_texcoord * _FringeEmissionMap_ST.xy + _FringeEmissionMap_ST.zw;
			float2 panner116_g1 = ( 1.0 * _Time.y * _FringeEmissionMap_Scroll + uv_FringeEmissionMap);
			float4 mfx_fringe_emission161_g1 = ( tex2D( _FringeEmissionMap, panner116_g1 ) * _FringeEmissionColor );
			float temp_output_87_0_g1 = ( 1.0 - _FringeSize );
			float2 uv_FringeRampMap = i.uv_texcoord * _FringeRampMap_ST.xy + _FringeRampMap_ST.zw;
			float2 panner57_g1 = ( 1.0 * _Time.y * _FringeRampMap_Scroll + uv_FringeRampMap);
			float4 tex2DNode68_g1 = tex2D( _FringeRampMap, panner57_g1 );
			float temp_output_78_0_g1 = ( ( _FringeOffset + ( mfx_mask_pos40_g1 - mfx_mask_offset38_g1 ) ) - tex2DNode68_g1.r );
			float smoothstepResult110_g1 = smoothstep( temp_output_87_0_g1 , ( temp_output_87_0_g1 + 0.1 ) , ( 1.0 - abs( temp_output_78_0_g1 ) ));
			float mfx_fringe_threshold170_g1 = ( saturate( ( smoothstepResult110_g1 - saturate( ( 1.0 - ceil( temp_output_78_0_g1 ) ) ) ) ) * ( ( 1.0 - mfx_edge_threshold108_g1 ) - mfx_edge119_g1 ) );
			float4 lerpResult177_g1 = lerp( (( mfx_alpha141_g1 <= _DissolveEdgeSize ) ? _DissolveEdgeColor :  ( mfx_emission129_g1 + ( _EdgeColor * mfx_edge119_g1 ) ) ) , mfx_fringe_emission161_g1 , mfx_fringe_threshold170_g1);
			float4 mfx_final_emission181_g1 = lerpResult177_g1;
			o.Emission = mfx_final_emission181_g1.rgb;
			o.Alpha = 1;
			clip( mfx_alpha141_g1 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "MfxShaderGui"
}
/*ASEBEGIN
Version=15600
189;114;1478;914;-890.5569;-323.5988;1;True;False
Node;AmplifyShaderEditor.FunctionNode;832;1364.557,663.5988;Float;False;GetMfxSingle;0;;1;9c3f88100a75314498e512de6691ced0;0;1;217;COLOR;0,0,0,0;False;5;COLOR;199;FLOAT;201;FLOAT3;200;FLOAT;222;FLOAT;223
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;831;1865.013,559.4293;Float;False;True;2;Float;MfxShaderGui;0;0;Unlit;QFX/MFX/ASE/Uber/Unlit;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.1;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;31;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;831;2;832;199
WireConnection;831;10;832;201
WireConnection;831;11;832;200
ASEEND*/
//CHKSM=4A2690EB76A92200737CE79BC01783ACCF204FFC