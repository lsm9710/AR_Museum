// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "QFX/MFX/ASE/Uber/Standard Transparent"
{
	Properties
	{
		_BumpMap("Normal Map", 2D) = "bump" {}
		_BumpScale("Bump Scale", Float) = 1
		[HDR]_FringeColor("Fringe Color", Color) = (0,0,0,1)
		[HDR]_Color2("Albedo Color 2", Color) = (0,0,0,1)
		_MainTex2("Albedo 2", 2D) = "white" {}
		_BumpMap2("Normal Map 2", 2D) = "bump" {}
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
		_MaskOffset("Mask Offset", Float) = 3.1
		[Toggle]_Invert("Invert", Float) = 0
		[KeywordEnum(None,AxisLocal,AxisGlobal,Global)] _MaskType("Mask Type", Float) = 2
		[KeywordEnum(X,Y,Z)] _CutoffAxis("Cutoff Axis", Float) = 1
		_WorldPositionOffset("World Position Offset", Vector) = (0,0,0,0)
		_MaskWorldPosition("Mask World Position", Vector) = (0,0,0,0)
		[HDR]_Color("Albedo Color", Color) = (1,1,1,1)
		[Toggle(_METALLICGLOSSMAP_ON)] _METALLICGLOSSMAP("METALLICGLOSSMAP", Float) = 0
		[KeywordEnum(MetallicAlpha,AlbedoAlpha)] _SmoothnessTextureChannel("Smoothness Texture Channel", Float) = 0
		_MainTex("Albedo", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.1
		_GlossMapScale("Smoothness Scale", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_MetallicGlossMap("Metallic Texture", 2D) = "white" {}
		_OcclusionMap("Occlusion", 2D) = "white" {}
		_OcclusionStrength("Occlusion", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _CUTOFFAXIS_X _CUTOFFAXIS_Y _CUTOFFAXIS_Z
		#pragma shader_feature _MASKTYPE_NONE _MASKTYPE_AXISLOCAL _MASKTYPE_AXISGLOBAL _MASKTYPE_GLOBAL
		#pragma shader_feature _METALLICGLOSSMAP_ON
		#pragma shader_feature _SMOOTHNESSTEXTURECHANNEL_METALLICALPHA _SMOOTHNESSTEXTURECHANNEL_ALBEDOALPHA
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float2 uv2_texcoord2;
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
		uniform float _BumpScale;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _BumpMap2;
		uniform float4 _BumpMap2_ST;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color2;
		uniform sampler2D _MainTex2;
		uniform float4 _MainTex2_ST;
		uniform float4 _FringeColor;
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
		uniform float _Metallic;
		uniform float _Glossiness;
		uniform float _GlossMapScale;
		uniform sampler2D _MetallicGlossMap;
		uniform sampler2D _OcclusionMap;
		uniform float _OcclusionStrength;
		uniform float _Cutoff = 0.1;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_FringeRampMap = v.texcoord.xy * _FringeRampMap_ST.xy + _FringeRampMap_ST.zw;
			float2 panner57_g24 = ( 1.0 * _Time.y * _FringeRampMap_Scroll + uv_FringeRampMap);
			float4 tex2DNode68_g24 = tex2Dlod( _FringeRampMap, float4( panner57_g24, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			float temp_output_87_0_g24 = ( 1.0 - _FringeSize );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_4_0_g24 = ( ase_worldPos - _WorldPositionOffset );
			float3 temp_cast_0 = (1.0).xxx;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 temp_cast_1 = (length( ( temp_output_4_0_g24 - _MaskWorldPosition ) )).xxx;
			#if defined(_MASKTYPE_NONE)
				float3 staticSwitch10_g24 = temp_cast_0;
			#elif defined(_MASKTYPE_AXISLOCAL)
				float3 staticSwitch10_g24 = ase_vertex3Pos;
			#elif defined(_MASKTYPE_AXISGLOBAL)
				float3 staticSwitch10_g24 = temp_output_4_0_g24;
			#elif defined(_MASKTYPE_GLOBAL)
				float3 staticSwitch10_g24 = temp_cast_1;
			#else
				float3 staticSwitch10_g24 = temp_output_4_0_g24;
			#endif
			float3 break13_g24 = staticSwitch10_g24;
			#if defined(_CUTOFFAXIS_X)
				float staticSwitch20_g24 = break13_g24.x;
			#elif defined(_CUTOFFAXIS_Y)
				float staticSwitch20_g24 = break13_g24.y;
			#elif defined(_CUTOFFAXIS_Z)
				float staticSwitch20_g24 = break13_g24.z;
			#else
				float staticSwitch20_g24 = break13_g24.y;
			#endif
			float mfx_pos25_g24 = staticSwitch20_g24;
			float mfx_invert_option23_g24 = lerp(1.0,-1.0,_Invert);
			float temp_output_28_0_g24 = ( mfx_invert_option23_g24 * _MaskOffset );
			float mfx_mask_pos40_g24 = ( ( mfx_pos25_g24 * mfx_invert_option23_g24 ) - temp_output_28_0_g24 );
			float mfx_mask_offset38_g24 = temp_output_28_0_g24;
			float temp_output_78_0_g24 = ( ( _FringeOffset + ( mfx_mask_pos40_g24 - mfx_mask_offset38_g24 ) ) - tex2DNode68_g24.r );
			float smoothstepResult110_g24 = smoothstep( temp_output_87_0_g24 , ( temp_output_87_0_g24 + 0.1 ) , ( 1.0 - abs( temp_output_78_0_g24 ) ));
			float2 uv_EdgeRampMap1 = v.texcoord.xy * _EdgeRampMap1_ST.xy + _EdgeRampMap1_ST.zw;
			float2 panner27_g24 = ( 1.0 * _Time.y * _EdgeRampMap1_Scroll + uv_EdgeRampMap1);
			float2 uv_TexCoord31_g24 = v.texcoord.xy + panner27_g24;
			float mfx_edge_pos55_g24 = ( mfx_mask_pos40_g24 - ( temp_output_28_0_g24 - tex2Dlod( _EdgeRampMap1, float4( uv_TexCoord31_g24, 0, 0.0) ).r ) );
			float temp_output_84_0_g24 = saturate( ( 1.0 - ceil( mfx_edge_pos55_g24 ) ) );
			float mfx_edge_threshold108_g24 = temp_output_84_0_g24;
			float temp_output_66_0_g24 = ( 1.0 - _EdgeSize );
			float smoothstepResult85_g24 = smoothstep( temp_output_66_0_g24 , ( temp_output_66_0_g24 + 0.1 ) , ( 1.0 - abs( mfx_edge_pos55_g24 ) ));
			float mfx_edge119_g24 = saturate( ( smoothstepResult85_g24 - temp_output_84_0_g24 ) );
			float mfx_fringe_threshold170_g24 = ( saturate( ( smoothstepResult110_g24 - saturate( ( 1.0 - ceil( temp_output_78_0_g24 ) ) ) ) ) * ( ( 1.0 - mfx_edge_threshold108_g24 ) - mfx_edge119_g24 ) );
			float3 mfx_local_vert_offset184_g24 = ( tex2DNode68_g24.r * ( ase_vertexNormal * _FringeAmount ) * mfx_fringe_threshold170_g24 );
			v.vertex.xyz += mfx_local_vert_offset184_g24;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv2_BumpMap2 = i.uv2_texcoord2 * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_4_0_g24 = ( ase_worldPos - _WorldPositionOffset );
			float3 temp_cast_0 = (1.0).xxx;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 temp_cast_1 = (length( ( temp_output_4_0_g24 - _MaskWorldPosition ) )).xxx;
			#if defined(_MASKTYPE_NONE)
				float3 staticSwitch10_g24 = temp_cast_0;
			#elif defined(_MASKTYPE_AXISLOCAL)
				float3 staticSwitch10_g24 = ase_vertex3Pos;
			#elif defined(_MASKTYPE_AXISGLOBAL)
				float3 staticSwitch10_g24 = temp_output_4_0_g24;
			#elif defined(_MASKTYPE_GLOBAL)
				float3 staticSwitch10_g24 = temp_cast_1;
			#else
				float3 staticSwitch10_g24 = temp_output_4_0_g24;
			#endif
			float3 break13_g24 = staticSwitch10_g24;
			#if defined(_CUTOFFAXIS_X)
				float staticSwitch20_g24 = break13_g24.x;
			#elif defined(_CUTOFFAXIS_Y)
				float staticSwitch20_g24 = break13_g24.y;
			#elif defined(_CUTOFFAXIS_Z)
				float staticSwitch20_g24 = break13_g24.z;
			#else
				float staticSwitch20_g24 = break13_g24.y;
			#endif
			float mfx_pos25_g24 = staticSwitch20_g24;
			float mfx_invert_option23_g24 = lerp(1.0,-1.0,_Invert);
			float temp_output_28_0_g24 = ( mfx_invert_option23_g24 * _MaskOffset );
			float mfx_mask_pos40_g24 = ( ( mfx_pos25_g24 * mfx_invert_option23_g24 ) - temp_output_28_0_g24 );
			float2 uv_EdgeRampMap1 = i.uv_texcoord * _EdgeRampMap1_ST.xy + _EdgeRampMap1_ST.zw;
			float2 panner27_g24 = ( 1.0 * _Time.y * _EdgeRampMap1_Scroll + uv_EdgeRampMap1);
			float2 uv_TexCoord31_g24 = i.uv_texcoord + panner27_g24;
			float mfx_edge_pos55_g24 = ( mfx_mask_pos40_g24 - ( temp_output_28_0_g24 - tex2D( _EdgeRampMap1, uv_TexCoord31_g24 ).r ) );
			float temp_output_84_0_g24 = saturate( ( 1.0 - ceil( mfx_edge_pos55_g24 ) ) );
			float mfx_edge_threshold108_g24 = temp_output_84_0_g24;
			float temp_output_32_0_g25 = mfx_edge_threshold108_g24;
			float3 lerpResult28_g25 = lerp( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale ) , UnpackNormal( tex2D( _BumpMap2, uv2_BumpMap2 ) ) , temp_output_32_0_g25);
			float3 mfx_norma14_g25 = lerpResult28_g25;
			o.Normal = mfx_norma14_g25;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode28 = tex2D( _MainTex, uv_MainTex );
			float4 temp_output_827_0 = ( _Color * tex2DNode28 );
			float2 uv_MainTex2 = i.uv_texcoord * _MainTex2_ST.xy + _MainTex2_ST.zw;
			float4 lerpResult9_g25 = lerp( temp_output_827_0 , ( _Color2 * tex2D( _MainTex2, uv_MainTex2 ) ) , temp_output_32_0_g25);
			float temp_output_87_0_g24 = ( 1.0 - _FringeSize );
			float mfx_mask_offset38_g24 = temp_output_28_0_g24;
			float2 uv_FringeRampMap = i.uv_texcoord * _FringeRampMap_ST.xy + _FringeRampMap_ST.zw;
			float2 panner57_g24 = ( 1.0 * _Time.y * _FringeRampMap_Scroll + uv_FringeRampMap);
			float4 tex2DNode68_g24 = tex2D( _FringeRampMap, panner57_g24 );
			float temp_output_78_0_g24 = ( ( _FringeOffset + ( mfx_mask_pos40_g24 - mfx_mask_offset38_g24 ) ) - tex2DNode68_g24.r );
			float smoothstepResult110_g24 = smoothstep( temp_output_87_0_g24 , ( temp_output_87_0_g24 + 0.1 ) , ( 1.0 - abs( temp_output_78_0_g24 ) ));
			float temp_output_66_0_g24 = ( 1.0 - _EdgeSize );
			float smoothstepResult85_g24 = smoothstep( temp_output_66_0_g24 , ( temp_output_66_0_g24 + 0.1 ) , ( 1.0 - abs( mfx_edge_pos55_g24 ) ));
			float mfx_edge119_g24 = saturate( ( smoothstepResult85_g24 - temp_output_84_0_g24 ) );
			float mfx_fringe_threshold170_g24 = ( saturate( ( smoothstepResult110_g24 - saturate( ( 1.0 - ceil( temp_output_78_0_g24 ) ) ) ) ) * ( ( 1.0 - mfx_edge_threshold108_g24 ) - mfx_edge119_g24 ) );
			float4 lerpResult12_g25 = lerp( lerpResult9_g25 , _FringeColor , mfx_fringe_threshold170_g24);
			float4 myVarName18_g25 = lerpResult12_g25;
			float4 temp_output_831_0 = myVarName18_g25;
			o.Albedo = temp_output_831_0.rgb;
			float2 uv_DissolveMap1 = i.uv_texcoord * _DissolveMap1_ST.xy + _DissolveMap1_ST.zw;
			float2 panner83_g24 = ( 1.0 * _Time.y * _DissolveMap1_Scroll + uv_DissolveMap1);
			float mfx_alpha141_g24 = ( _DissolveSize + ( mfx_mask_pos40_g24 - ( temp_output_28_0_g24 - tex2D( _DissolveMap1, panner83_g24 ).r ) ) );
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 uv_EmissionMap2 = i.uv_texcoord * _EmissionMap2_ST.xy + _EmissionMap2_ST.zw;
			float2 panner22_g24 = ( 1.0 * _Time.y * _EmissionMap2_Scroll + uv_EmissionMap2);
			float4 tex2DNode29_g24 = tex2D( _EmissionMap2, panner22_g24 );
			float clampResult53_g24 = clamp( ( ( ( 1.0 - tex2DNode29_g24.r ) - 0.5 ) * 3.0 ) , 0.0 , 1.0 );
			float4 mfx_emission_297_g24 = lerp(( _EmissionColor2 * tex2DNode29_g24.r ),( _EmissionColor2 * ( pow( clampResult53_g24 , 3.0 ) * saturate( ( ( mfx_mask_pos40_g24 - mfx_mask_offset38_g24 ) + (0.0 + (_EmissionSize2 - 0.0) * (3.0 - 0.0) / (1.0 - 0.0)) ) ) ) ),_EmissionSmooth2);
			float4 lerpResult113_g24 = lerp( ( _EmissionColor * tex2D( _EmissionMap, uv_EmissionMap ) ) , mfx_emission_297_g24 , mfx_edge_threshold108_g24);
			float4 mfx_emission129_g24 = lerpResult113_g24;
			float2 uv_FringeEmissionMap = i.uv_texcoord * _FringeEmissionMap_ST.xy + _FringeEmissionMap_ST.zw;
			float2 panner116_g24 = ( 1.0 * _Time.y * _FringeEmissionMap_Scroll + uv_FringeEmissionMap);
			float4 mfx_fringe_emission161_g24 = ( tex2D( _FringeEmissionMap, panner116_g24 ) * _FringeEmissionColor );
			float4 lerpResult177_g24 = lerp( (( mfx_alpha141_g24 <= _DissolveEdgeSize ) ? _DissolveEdgeColor :  ( mfx_emission129_g24 + ( _EdgeColor * mfx_edge119_g24 ) ) ) , mfx_fringe_emission161_g24 , mfx_fringe_threshold170_g24);
			float4 mfx_final_emission181_g24 = lerpResult177_g24;
			o.Emission = mfx_final_emission181_g24.rgb;
			float temp_output_38_0_g26 = _Metallic;
			float2 appendResult19_g26 = (float2(temp_output_38_0_g26 , _Glossiness));
			float temp_output_40_0_g26 = _GlossMapScale;
			float temp_output_42_0_g26 = tex2DNode28.a;
			float2 appendResult23_g26 = (float2(temp_output_38_0_g26 , ( temp_output_40_0_g26 * temp_output_42_0_g26 )));
			#if defined(_SMOOTHNESSTEXTURECHANNEL_METALLICALPHA)
				float staticSwitch45_g26 = 0.0;
			#elif defined(_SMOOTHNESSTEXTURECHANNEL_ALBEDOALPHA)
				float staticSwitch45_g26 = 1.0;
			#else
				float staticSwitch45_g26 = 0.0;
			#endif
			float texturechannel46_g26 = staticSwitch45_g26;
			float2 lerpResult25_g26 = lerp( appendResult19_g26 , appendResult23_g26 , texturechannel46_g26);
			float4 tex2DNode117 = tex2D( _MetallicGlossMap, uv_MainTex );
			float2 appendResult645 = (float2(tex2DNode117.r , tex2DNode117.a));
			float2 break37_g26 = appendResult645;
			float2 appendResult21_g26 = (float2(break37_g26.x , ( break37_g26.y * temp_output_40_0_g26 )));
			float2 appendResult20_g26 = (float2(break37_g26.x , ( temp_output_42_0_g26 * temp_output_40_0_g26 )));
			float2 lerpResult24_g26 = lerp( appendResult21_g26 , appendResult20_g26 , texturechannel46_g26);
			#ifdef _METALLICGLOSSMAP_ON
				float2 staticSwitch26_g26 = lerpResult24_g26;
			#else
				float2 staticSwitch26_g26 = lerpResult25_g26;
			#endif
			float2 break27_g26 = staticSwitch26_g26;
			float Metallic122 = break27_g26.x;
			o.Metallic = Metallic122;
			float Smothness121 = break27_g26.y;
			o.Smoothness = Smothness121;
			float lerpResult128 = lerp( 1.0 , tex2D( _OcclusionMap, uv_MainTex ).r , _OcclusionStrength);
			float occlusion129 = lerpResult128;
			o.Occlusion = occlusion129;
			o.Alpha = saturate( ( (temp_output_831_0).a * (temp_output_827_0).a ) );
			clip( mfx_alpha141_g24 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack1.zw = customInputData.uv2_texcoord2;
				o.customPack1.zw = v.texcoord1;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.uv2_texcoord2 = IN.customPack1.zw;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "MfxShaderGui"
}
/*ASEBEGIN
Version=15600
229;99;1478;944;3505.71;115.8021;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;139;-3320.385,153.1452;Float;False;464.2996;688.226;;4;827;28;27;561;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;561;-3255.246,600.6472;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-3258.438,235.4664;Float;False;Property;_Color;Albedo Color;40;1;[HDR];Create;False;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;28;-3277.634,406.1701;Float;True;Property;_MainTex;Albedo;44;0;Create;False;0;0;False;0;None;64e7766099ad46747a07014e44d0aea1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;115;-3321.184,-521.593;Float;False;1566.448;606.3427;;9;121;122;534;645;116;118;117;555;648;Metallic & Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;829;-2684.267,483.6815;Float;False;GetMfxSingle;9;;24;9c3f88100a75314498e512de6691ced0;0;1;217;COLOR;0,0,0,0;False;5;COLOR;199;FLOAT;201;FLOAT3;200;FLOAT;222;FLOAT;223
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;827;-3031.418,301.8012;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;125;-3332.72,955.2072;Float;False;832.5983;527.703;;5;562;129;128;126;127;Ambient Occlusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;555;-3241.129,-398.9237;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;831;-2279.746,327.2552;Float;False;GetMfxAlbedoNormal;0;;25;0ed64765209a0d24ba3cbdf31229ebcf;0;5;32;FLOAT;0;False;33;FLOAT;0;False;30;COLOR;0,0,0,0;False;18;FLOAT3;0,0,0;False;22;COLOR;0,0,0,0;False;2;COLOR;0;FLOAT3;35
Node;AmplifyShaderEditor.SamplerNode;117;-2989.493,-422.6545;Float;True;Property;_MetallicGlossMap;Metallic Texture;49;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;562;-3253.253,1045.805;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;126;-3254.802,1166.305;Float;True;Property;_OcclusionMap;Occlusion;50;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;830;-2743.897,671.7363;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;833;-2740.009,749.998;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-2969.59,-213.4382;Float;False;Property;_Metallic;Metallic;48;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;645;-2701.275,-380.7859;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;534;-2967.158,-38.72582;Float;False;Property;_GlossMapScale;Smoothness Scale;46;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;-2970.43,-127.6131;Float;False;Property;_Glossiness;Smoothness;47;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-3254.802,1374.304;Float;False;Property;_OcclusionStrength;Occlusion;51;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;832;-2541.507,686.5701;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;128;-2915.672,1242.707;Float;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;648;-2444.452,-242.1904;Float;False;GetMetallicSmoothness;41;;26;6d504252d6074bc4093c6306b92e1b21;0;5;42;FLOAT;0;False;33;FLOAT2;0,0;False;38;FLOAT;0;False;39;FLOAT;0;False;40;FLOAT;0;False;2;FLOAT;0;FLOAT;30
Node;AmplifyShaderEditor.GetLocalVarNode;123;-2180.991,793.6592;Float;False;122;Metallic;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;834;-2415.011,688.8979;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;130;-2178,958.1201;Float;False;129;occlusion;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-2022.462,-261.4642;Float;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;129;-2731.573,1239.284;Float;False;occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-2026.475,-158.7401;Float;False;Smothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-2194.135,874.4309;Float;False;121;Smothness;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1856.499,435.0024;Float;False;True;2;Float;MfxShaderGui;0;0;Standard;QFX/MFX/ASE/Uber/Standard Transparent;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.1;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;45;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;405;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;1;561;0
WireConnection;827;0;27;0
WireConnection;827;1;28;0
WireConnection;831;32;829;222
WireConnection;831;33;829;223
WireConnection;831;22;827;0
WireConnection;117;1;555;0
WireConnection;126;1;562;0
WireConnection;830;0;831;0
WireConnection;833;0;827;0
WireConnection;645;0;117;1
WireConnection;645;1;117;4
WireConnection;832;0;830;0
WireConnection;832;1;833;0
WireConnection;128;1;126;1
WireConnection;128;2;127;0
WireConnection;648;42;28;4
WireConnection;648;33;645;0
WireConnection;648;38;116;0
WireConnection;648;39;118;0
WireConnection;648;40;534;0
WireConnection;834;0;832;0
WireConnection;122;0;648;0
WireConnection;129;0;128;0
WireConnection;121;0;648;30
WireConnection;0;0;831;0
WireConnection;0;1;831;35
WireConnection;0;2;829;199
WireConnection;0;3;123;0
WireConnection;0;4;124;0
WireConnection;0;5;130;0
WireConnection;0;9;834;0
WireConnection;0;10;829;201
WireConnection;0;11;829;200
ASEEND*/
//CHKSM=B4BE779079174268A2E37E75A1C94D05F474742E