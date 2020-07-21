// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "QFX/MFX/ASE/Uber/Standard"
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
		_MaskOffset("Mask Offset", Float) = 1.04
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
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature _CUTOFFAXIS_X _CUTOFFAXIS_Y _CUTOFFAXIS_Z
		#pragma shader_feature _MASKTYPE_NONE _MASKTYPE_AXISLOCAL _MASKTYPE_AXISGLOBAL _MASKTYPE_GLOBAL
		#pragma shader_feature _METALLICGLOSSMAP_ON
		#pragma shader_feature _SMOOTHNESSTEXTURECHANNEL_METALLICALPHA _SMOOTHNESSTEXTURECHANNEL_ALBEDOALPHA
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
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
			float2 panner57_g29 = ( 1.0 * _Time.y * _FringeRampMap_Scroll + uv_FringeRampMap);
			float4 tex2DNode68_g29 = tex2Dlod( _FringeRampMap, float4( panner57_g29, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			float temp_output_87_0_g29 = ( 1.0 - _FringeSize );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_4_0_g29 = ( ase_worldPos - _WorldPositionOffset );
			float3 temp_cast_0 = (1.0).xxx;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 temp_cast_1 = (length( ( temp_output_4_0_g29 - _MaskWorldPosition ) )).xxx;
			#if defined(_MASKTYPE_NONE)
				float3 staticSwitch10_g29 = temp_cast_0;
			#elif defined(_MASKTYPE_AXISLOCAL)
				float3 staticSwitch10_g29 = ase_vertex3Pos;
			#elif defined(_MASKTYPE_AXISGLOBAL)
				float3 staticSwitch10_g29 = temp_output_4_0_g29;
			#elif defined(_MASKTYPE_GLOBAL)
				float3 staticSwitch10_g29 = temp_cast_1;
			#else
				float3 staticSwitch10_g29 = temp_output_4_0_g29;
			#endif
			float3 break13_g29 = staticSwitch10_g29;
			#if defined(_CUTOFFAXIS_X)
				float staticSwitch20_g29 = break13_g29.x;
			#elif defined(_CUTOFFAXIS_Y)
				float staticSwitch20_g29 = break13_g29.y;
			#elif defined(_CUTOFFAXIS_Z)
				float staticSwitch20_g29 = break13_g29.z;
			#else
				float staticSwitch20_g29 = break13_g29.y;
			#endif
			float mfx_pos25_g29 = staticSwitch20_g29;
			float mfx_invert_option23_g29 = lerp(1.0,-1.0,_Invert);
			float temp_output_28_0_g29 = ( mfx_invert_option23_g29 * _MaskOffset );
			float mfx_mask_pos40_g29 = ( ( mfx_pos25_g29 * mfx_invert_option23_g29 ) - temp_output_28_0_g29 );
			float mfx_mask_offset38_g29 = temp_output_28_0_g29;
			float temp_output_78_0_g29 = ( ( _FringeOffset + ( mfx_mask_pos40_g29 - mfx_mask_offset38_g29 ) ) - tex2DNode68_g29.r );
			float smoothstepResult110_g29 = smoothstep( temp_output_87_0_g29 , ( temp_output_87_0_g29 + 0.1 ) , ( 1.0 - abs( temp_output_78_0_g29 ) ));
			float2 uv_EdgeRampMap1 = v.texcoord.xy * _EdgeRampMap1_ST.xy + _EdgeRampMap1_ST.zw;
			float2 panner27_g29 = ( 1.0 * _Time.y * _EdgeRampMap1_Scroll + uv_EdgeRampMap1);
			float2 uv_TexCoord31_g29 = v.texcoord.xy + panner27_g29;
			float mfx_edge_pos55_g29 = ( mfx_mask_pos40_g29 - ( temp_output_28_0_g29 - tex2Dlod( _EdgeRampMap1, float4( uv_TexCoord31_g29, 0, 0.0) ).r ) );
			float temp_output_84_0_g29 = saturate( ( 1.0 - ceil( mfx_edge_pos55_g29 ) ) );
			float mfx_edge_threshold108_g29 = temp_output_84_0_g29;
			float temp_output_66_0_g29 = ( 1.0 - _EdgeSize );
			float smoothstepResult85_g29 = smoothstep( temp_output_66_0_g29 , ( temp_output_66_0_g29 + 0.1 ) , ( 1.0 - abs( mfx_edge_pos55_g29 ) ));
			float mfx_edge119_g29 = saturate( ( smoothstepResult85_g29 - temp_output_84_0_g29 ) );
			float mfx_fringe_threshold170_g29 = ( saturate( ( smoothstepResult110_g29 - saturate( ( 1.0 - ceil( temp_output_78_0_g29 ) ) ) ) ) * ( ( 1.0 - mfx_edge_threshold108_g29 ) - mfx_edge119_g29 ) );
			float3 mfx_local_vert_offset184_g29 = ( tex2DNode68_g29.r * ( ase_vertexNormal * _FringeAmount ) * mfx_fringe_threshold170_g29 );
			v.vertex.xyz += mfx_local_vert_offset184_g29;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv2_BumpMap2 = i.uv2_texcoord2 * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_4_0_g29 = ( ase_worldPos - _WorldPositionOffset );
			float3 temp_cast_0 = (1.0).xxx;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 temp_cast_1 = (length( ( temp_output_4_0_g29 - _MaskWorldPosition ) )).xxx;
			#if defined(_MASKTYPE_NONE)
				float3 staticSwitch10_g29 = temp_cast_0;
			#elif defined(_MASKTYPE_AXISLOCAL)
				float3 staticSwitch10_g29 = ase_vertex3Pos;
			#elif defined(_MASKTYPE_AXISGLOBAL)
				float3 staticSwitch10_g29 = temp_output_4_0_g29;
			#elif defined(_MASKTYPE_GLOBAL)
				float3 staticSwitch10_g29 = temp_cast_1;
			#else
				float3 staticSwitch10_g29 = temp_output_4_0_g29;
			#endif
			float3 break13_g29 = staticSwitch10_g29;
			#if defined(_CUTOFFAXIS_X)
				float staticSwitch20_g29 = break13_g29.x;
			#elif defined(_CUTOFFAXIS_Y)
				float staticSwitch20_g29 = break13_g29.y;
			#elif defined(_CUTOFFAXIS_Z)
				float staticSwitch20_g29 = break13_g29.z;
			#else
				float staticSwitch20_g29 = break13_g29.y;
			#endif
			float mfx_pos25_g29 = staticSwitch20_g29;
			float mfx_invert_option23_g29 = lerp(1.0,-1.0,_Invert);
			float temp_output_28_0_g29 = ( mfx_invert_option23_g29 * _MaskOffset );
			float mfx_mask_pos40_g29 = ( ( mfx_pos25_g29 * mfx_invert_option23_g29 ) - temp_output_28_0_g29 );
			float2 uv_EdgeRampMap1 = i.uv_texcoord * _EdgeRampMap1_ST.xy + _EdgeRampMap1_ST.zw;
			float2 panner27_g29 = ( 1.0 * _Time.y * _EdgeRampMap1_Scroll + uv_EdgeRampMap1);
			float2 uv_TexCoord31_g29 = i.uv_texcoord + panner27_g29;
			float mfx_edge_pos55_g29 = ( mfx_mask_pos40_g29 - ( temp_output_28_0_g29 - tex2D( _EdgeRampMap1, uv_TexCoord31_g29 ).r ) );
			float temp_output_84_0_g29 = saturate( ( 1.0 - ceil( mfx_edge_pos55_g29 ) ) );
			float mfx_edge_threshold108_g29 = temp_output_84_0_g29;
			float temp_output_32_0_g30 = mfx_edge_threshold108_g29;
			float3 lerpResult28_g30 = lerp( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale ) , UnpackNormal( tex2D( _BumpMap2, uv2_BumpMap2 ) ) , temp_output_32_0_g30);
			float3 mfx_norma14_g30 = lerpResult28_g30;
			o.Normal = mfx_norma14_g30;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode28 = tex2D( _MainTex, uv_MainTex );
			float2 uv_MainTex2 = i.uv_texcoord * _MainTex2_ST.xy + _MainTex2_ST.zw;
			float4 lerpResult9_g30 = lerp( ( _Color * tex2DNode28 ) , ( _Color2 * tex2D( _MainTex2, uv_MainTex2 ) ) , temp_output_32_0_g30);
			float temp_output_87_0_g29 = ( 1.0 - _FringeSize );
			float mfx_mask_offset38_g29 = temp_output_28_0_g29;
			float2 uv_FringeRampMap = i.uv_texcoord * _FringeRampMap_ST.xy + _FringeRampMap_ST.zw;
			float2 panner57_g29 = ( 1.0 * _Time.y * _FringeRampMap_Scroll + uv_FringeRampMap);
			float4 tex2DNode68_g29 = tex2D( _FringeRampMap, panner57_g29 );
			float temp_output_78_0_g29 = ( ( _FringeOffset + ( mfx_mask_pos40_g29 - mfx_mask_offset38_g29 ) ) - tex2DNode68_g29.r );
			float smoothstepResult110_g29 = smoothstep( temp_output_87_0_g29 , ( temp_output_87_0_g29 + 0.1 ) , ( 1.0 - abs( temp_output_78_0_g29 ) ));
			float temp_output_66_0_g29 = ( 1.0 - _EdgeSize );
			float smoothstepResult85_g29 = smoothstep( temp_output_66_0_g29 , ( temp_output_66_0_g29 + 0.1 ) , ( 1.0 - abs( mfx_edge_pos55_g29 ) ));
			float mfx_edge119_g29 = saturate( ( smoothstepResult85_g29 - temp_output_84_0_g29 ) );
			float mfx_fringe_threshold170_g29 = ( saturate( ( smoothstepResult110_g29 - saturate( ( 1.0 - ceil( temp_output_78_0_g29 ) ) ) ) ) * ( ( 1.0 - mfx_edge_threshold108_g29 ) - mfx_edge119_g29 ) );
			float4 lerpResult12_g30 = lerp( lerpResult9_g30 , _FringeColor , mfx_fringe_threshold170_g29);
			float4 myVarName18_g30 = lerpResult12_g30;
			o.Albedo = myVarName18_g30.rgb;
			float2 uv_DissolveMap1 = i.uv_texcoord * _DissolveMap1_ST.xy + _DissolveMap1_ST.zw;
			float2 panner83_g29 = ( 1.0 * _Time.y * _DissolveMap1_Scroll + uv_DissolveMap1);
			float mfx_alpha141_g29 = ( _DissolveSize + ( mfx_mask_pos40_g29 - ( temp_output_28_0_g29 - tex2D( _DissolveMap1, panner83_g29 ).r ) ) );
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 uv_EmissionMap2 = i.uv_texcoord * _EmissionMap2_ST.xy + _EmissionMap2_ST.zw;
			float2 panner22_g29 = ( 1.0 * _Time.y * _EmissionMap2_Scroll + uv_EmissionMap2);
			float4 tex2DNode29_g29 = tex2D( _EmissionMap2, panner22_g29 );
			float clampResult53_g29 = clamp( ( ( ( 1.0 - tex2DNode29_g29.r ) - 0.5 ) * 3.0 ) , 0.0 , 1.0 );
			float4 mfx_emission_297_g29 = lerp(( _EmissionColor2 * tex2DNode29_g29.r ),( _EmissionColor2 * ( pow( clampResult53_g29 , 3.0 ) * saturate( ( ( mfx_mask_pos40_g29 - mfx_mask_offset38_g29 ) + (0.0 + (_EmissionSize2 - 0.0) * (3.0 - 0.0) / (1.0 - 0.0)) ) ) ) ),_EmissionSmooth2);
			float4 lerpResult113_g29 = lerp( ( _EmissionColor * tex2D( _EmissionMap, uv_EmissionMap ) ) , mfx_emission_297_g29 , mfx_edge_threshold108_g29);
			float4 mfx_emission129_g29 = lerpResult113_g29;
			float2 uv_FringeEmissionMap = i.uv_texcoord * _FringeEmissionMap_ST.xy + _FringeEmissionMap_ST.zw;
			float2 panner116_g29 = ( 1.0 * _Time.y * _FringeEmissionMap_Scroll + uv_FringeEmissionMap);
			float4 mfx_fringe_emission161_g29 = ( tex2D( _FringeEmissionMap, panner116_g29 ) * _FringeEmissionColor );
			float4 lerpResult177_g29 = lerp( (( mfx_alpha141_g29 <= _DissolveEdgeSize ) ? _DissolveEdgeColor :  ( mfx_emission129_g29 + ( _EdgeColor * mfx_edge119_g29 ) ) ) , mfx_fringe_emission161_g29 , mfx_fringe_threshold170_g29);
			float4 mfx_final_emission181_g29 = lerpResult177_g29;
			o.Emission = mfx_final_emission181_g29.rgb;
			float temp_output_38_0_g21 = _Metallic;
			float2 appendResult19_g21 = (float2(temp_output_38_0_g21 , _Glossiness));
			float temp_output_40_0_g21 = _GlossMapScale;
			float temp_output_42_0_g21 = tex2DNode28.a;
			float2 appendResult23_g21 = (float2(temp_output_38_0_g21 , ( temp_output_40_0_g21 * temp_output_42_0_g21 )));
			#if defined(_SMOOTHNESSTEXTURECHANNEL_METALLICALPHA)
				float staticSwitch45_g21 = 0.0;
			#elif defined(_SMOOTHNESSTEXTURECHANNEL_ALBEDOALPHA)
				float staticSwitch45_g21 = 1.0;
			#else
				float staticSwitch45_g21 = 0.0;
			#endif
			float texturechannel46_g21 = staticSwitch45_g21;
			float2 lerpResult25_g21 = lerp( appendResult19_g21 , appendResult23_g21 , texturechannel46_g21);
			float4 tex2DNode117 = tex2D( _MetallicGlossMap, uv_MainTex );
			float2 appendResult645 = (float2(tex2DNode117.r , tex2DNode117.a));
			float2 break37_g21 = appendResult645;
			float2 appendResult21_g21 = (float2(break37_g21.x , ( break37_g21.y * temp_output_40_0_g21 )));
			float2 appendResult20_g21 = (float2(break37_g21.x , ( temp_output_42_0_g21 * temp_output_40_0_g21 )));
			float2 lerpResult24_g21 = lerp( appendResult21_g21 , appendResult20_g21 , texturechannel46_g21);
			#ifdef _METALLICGLOSSMAP_ON
				float2 staticSwitch26_g21 = lerpResult24_g21;
			#else
				float2 staticSwitch26_g21 = lerpResult25_g21;
			#endif
			float2 break27_g21 = staticSwitch26_g21;
			float Metallic122 = break27_g21.x;
			o.Metallic = Metallic122;
			float Smothness121 = break27_g21.y;
			o.Smoothness = Smothness121;
			float lerpResult128 = lerp( 1.0 , tex2D( _OcclusionMap, uv_MainTex ).r , _OcclusionStrength);
			float occlusion129 = lerpResult128;
			o.Occlusion = occlusion129;
			o.Alpha = 1;
			clip( mfx_alpha141_g29 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "MfxShaderGui"
}
/*ASEBEGIN
Version=15600
7;29;1906;1014;5941.102;1748.882;2.378654;True;False
Node;AmplifyShaderEditor.CommentaryNode;139;-4320.757,-767.0082;Float;False;547.281;621.5758;;4;827;28;27;561;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;115;-4321.556,-1441.746;Float;False;1566.448;606.3427;;9;121;122;534;645;116;118;117;555;648;Metallic & Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;561;-4255.618,-319.5062;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;555;-4241.501,-1319.077;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;125;-4305.222,-3.542558;Float;False;832.5983;527.703;;5;562;129;128;126;127;Ambient Occlusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;28;-4278.006,-513.9833;Float;True;Property;_MainTex;Albedo;44;0;Create;False;0;0;False;0;None;64e7766099ad46747a07014e44d0aea1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-4258.81,-684.687;Float;False;Property;_Color;Albedo Color;40;1;[HDR];Create;False;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;117;-3989.865,-1342.808;Float;True;Property;_MetallicGlossMap;Metallic Texture;49;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;562;-4225.755,87.05545;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;534;-3967.53,-958.8792;Float;False;Property;_GlossMapScale;Smoothness Scale;46;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;126;-4227.304,207.5556;Float;True;Property;_OcclusionMap;Occlusion;50;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;827;-4031.79,-618.3522;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;645;-3701.647,-1300.939;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-3969.962,-1133.592;Float;False;Property;_Metallic;Metallic;48;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;-3970.802,-1047.766;Float;False;Property;_Glossiness;Smoothness;47;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-4227.304,415.5546;Float;False;Property;_OcclusionStrength;Occlusion;51;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;838;-3631.535,-756.6093;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;128;-3888.17,283.9576;Float;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;648;-3444.824,-1162.344;Float;False;GetMetallicSmoothness;41;;21;6d504252d6074bc4093c6306b92e1b21;0;5;42;FLOAT;0;False;33;FLOAT2;0,0;False;38;FLOAT;0;False;39;FLOAT;0;False;40;FLOAT;0;False;2;FLOAT;0;FLOAT;30
Node;AmplifyShaderEditor.FunctionNode;839;-3708.672,-664.2739;Float;False;GetMfxSingle;9;;29;9c3f88100a75314498e512de6691ced0;0;1;217;COLOR;0,0,0,0;False;5;COLOR;199;FLOAT;201;FLOAT3;200;FLOAT;222;FLOAT;223
Node;AmplifyShaderEditor.GetLocalVarNode;123;-3108.585,-377.0239;Float;False;122;Metallic;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-3022.834,-1181.618;Float;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-3121.486,-293.524;Float;False;121;Smothness;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;130;-3109.442,-208.2268;Float;False;129;occlusion;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;129;-3704.072,280.5345;Float;False;occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-3026.847,-1078.893;Float;False;Smothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;835;-3282.325,-782.967;Float;False;GetMfxAlbedoNormal;0;;30;0ed64765209a0d24ba3cbdf31229ebcf;0;5;32;FLOAT;0;False;33;FLOAT;0;False;30;COLOR;0,0,0,0;False;18;FLOAT3;0,0,0;False;22;COLOR;0,0,0,0;False;2;COLOR;0;FLOAT3;35
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-2791.462,-653.0265;Float;False;True;2;Float;MfxShaderGui;0;0;Standard;QFX/MFX/ASE/Uber/Standard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.1;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;45;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;405;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;1;561;0
WireConnection;117;1;555;0
WireConnection;126;1;562;0
WireConnection;827;0;27;0
WireConnection;827;1;28;0
WireConnection;645;0;117;1
WireConnection;645;1;117;4
WireConnection;838;0;827;0
WireConnection;128;1;126;1
WireConnection;128;2;127;0
WireConnection;648;42;28;4
WireConnection;648;33;645;0
WireConnection;648;38;116;0
WireConnection;648;39;118;0
WireConnection;648;40;534;0
WireConnection;122;0;648;0
WireConnection;129;0;128;0
WireConnection;121;0;648;30
WireConnection;835;32;839;222
WireConnection;835;33;839;223
WireConnection;835;22;838;0
WireConnection;0;0;835;0
WireConnection;0;1;835;35
WireConnection;0;2;839;199
WireConnection;0;3;123;0
WireConnection;0;4;124;0
WireConnection;0;5;130;0
WireConnection;0;10;839;201
WireConnection;0;11;839;200
ASEEND*/
//CHKSM=BC1B4BCA8549D2A8BB51CE4B73F4DAA425968C80