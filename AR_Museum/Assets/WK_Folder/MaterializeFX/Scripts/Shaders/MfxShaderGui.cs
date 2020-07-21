#if UNITY_EDITOR
using System;
using UnityEditor;
using UnityEngine;

// ReSharper disable once UnusedMember.Global
// ReSharper disable once CheckNamespace
internal sealed class MfxShaderGui : MfxStandardGui
{
    private MaterialProperty _albedoMap2;
    private MaterialProperty _albedoColor2;

    //private MaterialProperty _bumpScale;
    private MaterialProperty _bumpMap2;

    private MaterialProperty _emissionMap2;
    private MaterialProperty _emissionColor2ForRendering;
    private MaterialProperty _emissionSize2;
    private MaterialProperty _emissionSmooth2;
    private MaterialProperty _emissionMap2Scroll;

    private MaterialProperty _edgeMap;
    private MaterialProperty _edgeColor;
    private MaterialProperty _edgeScroll;
    private MaterialProperty _edgeSize;

    private MaterialProperty _dissolveMap;
    private MaterialProperty _dissolveColor;
    private MaterialProperty _dissolveScroll;
    private MaterialProperty _dissolveSize;
    private MaterialProperty _dissolveEdgeSize;

    private MaterialProperty _fringeRampMap;
    private MaterialProperty _fringeSize;
    private MaterialProperty _fringeAmount;
    private MaterialProperty _fringeOffset;
    private MaterialProperty _fringeColor;
    private MaterialProperty _fringeEmissionMap;
    private MaterialProperty _fringeEmissionColor;
    private MaterialProperty _fringeRampMapScroll;
    private MaterialProperty _fringeEmissionMapScroll;

    private MaterialProperty _invert;
    private MaterialProperty _maskType;
    private MaterialProperty _cutoffAxis;

    private MaterialProperty _maskOffset;
    private MaterialProperty _maskWorldPosition;

    private MaterialEditor _materialEditor;

#if UNITY_2017
    private const float kMaxfp16 = 65536f; // Clamp to a value that fits into fp16.
    ColorPickerHDRConfig m_ColorPickerHDRConfig = new ColorPickerHDRConfig(0f, kMaxfp16, 1 / kMaxfp16, 3f);
#endif

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        base.OnGUI(materialEditor, props);

        _materialEditor = materialEditor;
        var material = materialEditor.target as Material;

        FindMfxProperties(props);
        ShowShaderPropertiesGui(material);
    }

    public override void MaterialChanged(Material material)
    {
        base.MaterialChanged(material);

        if (material.HasProperty("_MaskType"))
        {
            var mfxMaskType = (MfxMaskType) material.GetFloat("_MaskType");
            switch (mfxMaskType)
            {
                case MfxMaskType.None:
                    SetKeyword(material, "_MASKTYPE_NONE", true);
                    break;
                case MfxMaskType.LocalAxis:
                    SetKeyword(material, "_MASKTYPE_AXISLOCAL", true);
                    break;
                case MfxMaskType.GlobalAxis:
                    SetKeyword(material, "_MASKTYPE_AXISGLOBAL", true);
                    break;
                case MfxMaskType.Global:
                    SetKeyword(material, "_MASKTYPE_GLOBAL", true);
                    break;
            }
        }

        if (material.HasProperty("_CutoffAxis"))
        {
            var axis = (CutoffAxis) material.GetFloat("_CutoffAxis");
            switch (axis)
            {
                case CutoffAxis.X:
                    SetKeyword(material, "_CUTOFFAXIS_X", true);
                    break;
                case CutoffAxis.Y:
                    SetKeyword(material, "_CUTOFFAXIS_Y", true);
                    break;
                case CutoffAxis.Z:
                    SetKeyword(material, "_CUTOFFAXIS_Z", true);
                    break;
            }
        }
    }

    private void FindMfxProperties(MaterialProperty[] props)
    {
        _albedoMap2 = FindProperty("_MainTex2", props, false);
        _albedoColor2 = FindProperty("_Color2", props, false);
        //_albedo2Scale = FindProperty("_Albedo2Scale", props);

        //_bumpScale = FindProperty("_BumpScale2", props);
        _bumpMap2 = FindProperty("_BumpMap2", props, false);

        _emissionMap2 = FindProperty("_EmissionMap2", props);
        _emissionColor2ForRendering = FindProperty("_EmissionColor2", props);
        _emissionSize2 = FindProperty("_EmissionSize2", props);
        _emissionSmooth2 = FindProperty("_EmissionSmooth2", props);
        _emissionMap2Scroll = FindProperty("_EmissionMap2_Scroll", props, false);

        _edgeMap = FindProperty("_EdgeRampMap1", props);
        _edgeColor = FindProperty("_EdgeColor", props);
        _edgeScroll = FindProperty("_EdgeRampMap1_Scroll", props);
        _edgeSize = FindProperty("_EdgeSize", props);

        _dissolveMap = FindProperty("_DissolveMap1", props);
        _dissolveColor = FindProperty("_DissolveEdgeColor", props);
        _dissolveScroll = FindProperty("_DissolveMap1_Scroll", props);
        _dissolveEdgeSize = FindProperty("_DissolveEdgeSize", props);
        _dissolveSize = FindProperty("_DissolveSize", props);

        _fringeRampMap = FindProperty("_FringeRampMap", props);
        _fringeSize = FindProperty("_FringeSize", props);
        _fringeAmount = FindProperty("_FringeAmount", props);
        _fringeOffset = FindProperty("_FringeOffset", props);
        _fringeEmissionMap = FindProperty("_FringeEmissionMap", props);
        _fringeEmissionColor = FindProperty("_FringeEmissionColor", props);
        _fringeColor = FindProperty("_FringeColor", props, false);
        _fringeRampMapScroll = FindProperty("_FringeRampMap_Scroll", props);
        _fringeEmissionMapScroll = FindProperty("_FringeEmissionMap_Scroll", props);

        _invert = FindProperty("_Invert", props);
        _maskType = FindProperty("_MaskType", props);
        _cutoffAxis = FindProperty("_CutoffAxis", props);

        _maskOffset = FindProperty("_MaskOffset", props);
        _maskWorldPosition = FindProperty("_MaskWorldPosition", props);
    }

    private void ShowShaderPropertiesGui(Material material)
    {
        EditorGUIUtility.labelWidth = 0f;

        // Detect any changes to the material 
        EditorGUI.BeginChangeCheck();
        {
            GUILayout.Label(MfxShaderGuiStyles.MfxLabelText, EditorStyles.boldLabel);

            DoAlbedo2Area();
            DoEmission2Area();
            DoNormalArea();
            DoEdgeArea();
            DoDissolveArea();
            DoFringeArea();
            DoPropsArea();
        }

        if (EditorGUI.EndChangeCheck())
        {
            //    //    foreach (var obj in blendModeProp.targets)
            //    //MaterialChanged((Material)obj);
            MaterialChanged(material);
        }
    }

    private void DoAlbedo2Area()
    {
        if (_albedoMap2 != null)
        {
            _materialEditor.TexturePropertySingleLine(MfxShaderGuiStyles.Albedo2Text, _albedoMap2, _albedoColor2);
            _materialEditor.TextureScaleOffsetProperty(_albedoMap2);
        }
    }

    private void DoEmission2Area()
    {
        var hadEmissionTexture = _emissionMap2.textureValue != null;

        // Texture and HDR color controls
#if UNITY_2017
        _materialEditor.TexturePropertyWithHDRColor(MfxShaderGuiStyles.Emission2Text, _emissionMap2,
            _emissionColor2ForRendering, m_ColorPickerHDRConfig, false);
#endif
#if UNITY_2018_2_OR_NEWER

#endif
        _materialEditor.TextureScaleOffsetProperty(_emissionMap2);

        // If texture was assigned and color was black set color to white
        float brightness = _emissionColor2ForRendering.colorValue.maxColorComponent;
        if (_emissionMap2.textureValue != null && !hadEmissionTexture && brightness <= 0f)
            _emissionColor2ForRendering.colorValue = Color.white;

        _materialEditor.ShaderProperty(_emissionSmooth2, MfxShaderGuiStyles.Emission2SmoothText);
        _materialEditor.FloatProperty(_emissionSize2, MfxShaderGuiStyles.Emission2SizeText);

        if (_emissionMap2Scroll != null)
            _materialEditor.VectorProperty(_emissionMap2Scroll, MfxShaderGuiStyles.Emission2ScrollText);
    }

    private void DoNormalArea()
    {
        if (_bumpMap2 != null)
        {
            _materialEditor.TexturePropertySingleLine(MfxShaderGuiStyles.NormalMap2Text, _bumpMap2);
            _materialEditor.TextureScaleOffsetProperty(_bumpMap2);
        }
    }

    private void DoEdgeArea()
    {
#if UNITY_2017
        _materialEditor.TexturePropertyWithHDRColor(MfxShaderGuiStyles.EdgeText, _edgeMap, _edgeColor,
            m_ColorPickerHDRConfig, false);
#endif
#if UNITY_2018_2_OR_NEWER
        _materialEditor.TexturePropertyWithHDRColor(MfxShaderGuiStyles.EdgeText, _edgeMap, _edgeColor, false);
#endif

        float brightness = _edgeColor.colorValue.maxColorComponent;
        if (_edgeMap.textureValue != null && brightness <= 0f)
            _edgeColor.colorValue = Color.white;

        _materialEditor.TextureScaleOffsetProperty(_edgeMap);

        _materialEditor.VectorProperty(_edgeScroll, MfxShaderGuiStyles.EdgeScrollText);
        _materialEditor.RangeProperty(_edgeSize, MfxShaderGuiStyles.EdgeSizeText);
    }

    private void DoDissolveArea()
    {
#if UNITY_2017
        _materialEditor.TexturePropertyWithHDRColor(MfxShaderGuiStyles.DissolveText, _dissolveMap, _dissolveColor,
            m_ColorPickerHDRConfig,
            false);
#endif
#if UNITY_2018_2_OR_NEWER
 _materialEditor.TexturePropertyWithHDRColor(MfxShaderGuiStyles.DissolveText, _dissolveMap, _dissolveColor, false);
#endif

        float brightness = _dissolveColor.colorValue.maxColorComponent;
        if (_dissolveMap.textureValue != null && brightness <= 0f)
            _dissolveColor.colorValue = Color.white;

        _materialEditor.TextureScaleOffsetProperty(_dissolveMap);

        _materialEditor.VectorProperty(_dissolveScroll, MfxShaderGuiStyles.DissolveScrollText);
        _materialEditor.RangeProperty(_dissolveSize, MfxShaderGuiStyles.DissolveSizeText);
        _materialEditor.RangeProperty(_dissolveEdgeSize, MfxShaderGuiStyles.DissolveEdgeSizeText);
    }

    private void DoFringeArea()
    {
        _materialEditor.TextureProperty(_fringeRampMap, MfxShaderGuiStyles.FringeRampMapText);
        _materialEditor.VectorProperty(_fringeRampMapScroll, MfxShaderGuiStyles.FringeScrollText);
        _materialEditor.FloatProperty(_fringeSize, MfxShaderGuiStyles.FringeSizeText);
        _materialEditor.FloatProperty(_fringeAmount, MfxShaderGuiStyles.FringeAmountText);
        _materialEditor.FloatProperty(_fringeOffset, MfxShaderGuiStyles.FringeOffsetText);
        if (_fringeColor != null)
            _materialEditor.ColorProperty(_fringeColor, MfxShaderGuiStyles.FringeColorText);
#if UNITY_2017
        _materialEditor.TexturePropertyWithHDRColor(MfxShaderGuiStyles.FringeEmissionText, _fringeEmissionMap,
            _fringeEmissionColor, m_ColorPickerHDRConfig, false);
#endif
#if UNITY_2018_2_OR_NEWER
  _materialEditor.TexturePropertyWithHDRColor(MfxShaderGuiStyles.FringeEmissionText, _fringeEmissionMap, _fringeEmissionColor, false);
#endif
        _materialEditor.TextureScaleOffsetProperty(_fringeEmissionMap);
        _materialEditor.VectorProperty(_fringeEmissionMapScroll, MfxShaderGuiStyles.FringeEmissionScrollText);
    }

    private void DoPropsArea()
    {
        _materialEditor.ShaderProperty(_invert, MfxShaderGuiStyles.InvertText);

        DoPopup(MfxShaderGuiStyles.MaskTypeText, _maskType, Enum.GetNames(typeof(MfxMaskType)));

        //_materialEditor.ShaderProperty(_maskType, MfxShaderGuiStyles.MaskTypeText);

        var maskType = (MfxMaskType) _maskType.floatValue;
        if (maskType == MfxMaskType.LocalAxis || maskType == MfxMaskType.GlobalAxis)
        {
            DoPopup(MfxShaderGuiStyles.CutoffAxisText, _cutoffAxis, Enum.GetNames(typeof(CutoffAxis)));
        }
        else if (maskType == MfxMaskType.Global)
        {
            _materialEditor.VectorProperty(_maskWorldPosition, MfxShaderGuiStyles.MaskWorldPositionText);
        }

        _materialEditor.FloatProperty(_maskOffset, MfxShaderGuiStyles.MaskOffsetText);
    }


    public enum MfxMaskType
    {
        None,
        LocalAxis,
        GlobalAxis,
        Global
    }

    public enum CutoffAxis
    {
        X,
        Y,
        Z
    }

    internal static class MfxShaderGuiStyles
    {
        public static string MfxLabelText = "MaterializeFX Props";

        public static GUIContent Albedo2Text = new GUIContent("Albedo 2", "Albedo 2");

        public static GUIContent NormalMap2Text = new GUIContent("Normal Map 2", "Normal Map 2");

        public static GUIContent Emission2Text = new GUIContent("Emission 2", "Emission 2 (RGB)");
        public static string Emission2SizeText = "Emission 2 Size";
        public static string Emission2SmoothText = "Emission 2 Smooth?";
        public static string Emission2ScrollText = "Emission 2 Scroll";

        public static GUIContent EdgeText = new GUIContent("Edge", "Edge");
        public static string EdgeScrollText = "Edge Scroll";
        public static string EdgeSizeText = "Edge Size";

        public static GUIContent DissolveText = new GUIContent("Dissolve", "Dissolve");
        public static string DissolveSizeText = "Dissolve Size";
        public static string DissolveEdgeSizeText = "Dissolve Edge Size";
        public static string DissolveScrollText = "Dissolve Scroll";

        public static string FringeRampMapText = "Fringe RampMap";
        public static string FringeColorText = "Fringe Color";
        public static string FringeSizeText = "Fringe Size";
        public static string FringeAmountText = "Fringe Amount";
        public static string FringeOffsetText = "Fringe Offset";
        public static string FringeScrollText = "Fringe RampMap Scroll";
        public static string FringeEmissionScrollText = "Fringe EmissionMap Scroll";

        public static GUIContent FringeEmissionText = new GUIContent("Fringe Emission");

        public static string InvertText = "Invert";

        public static string MaskTypeText = "MaskType";
        public static string CutoffAxisText = "Cutoff Axis";

        public static string MaskOffsetText = "Mask Offset";
        public static string MaskWorldPositionText = "Mask World Position";
    }
}
#endif