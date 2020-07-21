using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Rendering;
#if UNITY_EDITOR
using UnityEditor;
#endif

// ReSharper disable once CheckNamespace
namespace Assets.MaterializeFX.Scripts
{
    internal static class MfxMaterialUtil
    {
        private const string Color2PropName = "_Color2";
        private const string MainTex2PropName = "_MainTex2";
        private const string BumpMap2PropName = "_BumpMap2";
        private const string EmissionColor2PropName = "_EmissionColor2";
        private const string EmissionMap2PropName = "_EmissionMap2";
        private const string EmissionMap2ScrollPropName = "_EmissionMap2_Scroll";
        private const string EmissionSize2PropName = "_EmissionSize2";
        private const string EmissionSmoothPropName = "_EmissionSmooth2";
        private const string EdgeColorPropName = "_EdgeColor";
        private const string EdgeSizePropName = "_EdgeSize";
        private const string EdgeStrengthPropName = "_EdgeStrength";
        private const string EdgeRampMap1PropName = "_EdgeRampMap1";
        private const string EdgeRampMap1ScrollPropName = "_EdgeRampMap1_Scroll";
        private const string DissolveMap1PropName = "_DissolveMap1";
        private const string DissolveMap1ScrollPropName = "_DissolveMap1_Scroll";
        private const string MaskPropName = "_MaskType";
        private const string CutoffAxisPropName = "_CutoffAxis";
        private const string MaskOffsetPropName = "_MaskOffset";
        private const string DissolveSizePropName = "_DissolveSize";
        private const string DissolveEdgeColorPropName = "_DissolveEdgeColor";
        private const string DissolveEdgeSizePropName = "_DissolveEdgeSize";
        private const string FringeSizePropName = "_FringeSize";
        private const string FringeAmountPropName = "_FringeAmount";
        private const string FringeOffsetPropName = "_FringeOffset";
        private const string FringeRampMapPropName = "_FringeRampMap";
        private const string FringeEmissionMapPropName = "_FringeEmissionMap";
        private const string FringeEmissionColorPropName = "_FringeEmissionColor";
        private const string FringeEmissionMapScroll = "_FringeEmissionMap_Scroll";
        private const string FringeColorPropName = "_FringeColor";
        private const string InvertPropName = "_Invert";
        private const string CutoffPropName = "_Cutoff";
        
        public static void ReplaceRenderersMaterials(Material mfxTemplateMaterial, GameObject targetObject, bool determineWorkflowAutomatically, MfxShaderType mfxShaderType, 
            bool editorMode)
        {
            var renderers = targetObject.GetComponentsInChildren<Renderer>();

            foreach (var targetRenderer in renderers)
            {
                var targetRendererMaterials = targetRenderer.sharedMaterials;
                var newMaterials = ReplaceMaterialsToMfx(mfxTemplateMaterial, targetRendererMaterials, determineWorkflowAutomatically, mfxShaderType, editorMode);
                targetRenderer.sharedMaterials = newMaterials.ToArray();
            }
        }

        public static List<Material> ReplaceMaterialsToMfx(Material mfxTemplateMaterial, Material[] targetRendererMaterials, bool determineWorkflowAutomatically, 
            MfxShaderType mfxShaderType, bool editorMode)
        {
            var newMaterials = new List<Material>();

            foreach (var targetRendererMaterial in targetRendererMaterials)
            {
                if (targetRendererMaterial == null)
                    continue;

#if UNITY_EDITOR
                string newAssetPath = string.Empty;

                if (editorMode)
                {
                    var materialPath = AssetDatabase.GetAssetPath(targetRendererMaterial);

                    var extensionIdx = materialPath.LastIndexOf("/", StringComparison.Ordinal);
                    if (extensionIdx <= 0)
                    {
                        Debug.LogError("the path is incorrect");
                        continue;
                    }

                    var pathWithoutExtension = materialPath.Substring(0, extensionIdx);

                    newAssetPath = pathWithoutExtension + "/" + targetRendererMaterial.name + "_MFX.mat";

                    var assetType = AssetDatabase.GetMainAssetTypeAtPath(newAssetPath);
                    if (assetType != null)
                    {
                        var existingMaterial = AssetDatabase.LoadAssetAtPath<Material>(newAssetPath);
                        newMaterials.Add(existingMaterial);
                        continue;
                    }
                }
#endif

                var shaderName = determineWorkflowAutomatically ? GetShaderByWorkflow(targetRendererMaterial) : mfxShaderType.GetShaderName();
                var newMaterial = new Material(targetRendererMaterial)
                {
                    shader = Shader.Find(shaderName)
                };

                CopyMfxProperties(mfxTemplateMaterial, newMaterial, targetRendererMaterial, determineWorkflowAutomatically);

                ReplaceMetallicSpecularKeywords(targetRendererMaterial, newMaterial);
                
                newMaterials.Add(newMaterial);
                
#if UNITY_EDITOR
                if (editorMode)
                {
                    AssetDatabase.CreateAsset(newMaterial, newAssetPath);
                    Debug.Log("Mfx Material Was Created: " + newAssetPath);
                }
#endif
            }

            return newMaterials;
        }

        public static int GetMaterialsCount(GameObject targetObject)
        {
            var materialsCount = 0;

            var renderers = targetObject.GetComponentsInChildren<Renderer>();

            foreach (var targetRenderer in renderers)
            {
                var targetRendererMaterials = targetRenderer.sharedMaterials;
                materialsCount += targetRendererMaterials.Length;
            }

            return materialsCount;
        }

        private static void CopyMfxProperties(Material mfxTemplateMaterial, Material targetMfxMaterial, Material originalMaterial, bool determineWorkflow)
        {
            CopyPropertyToMaterial<Color>(mfxTemplateMaterial, targetMfxMaterial, Color2PropName, Color2PropName);
            CopyPropertyToMaterial<Texture>(mfxTemplateMaterial, targetMfxMaterial, MainTex2PropName, MainTex2PropName);
            CopyPropertyToMaterial<Texture>(mfxTemplateMaterial, targetMfxMaterial, BumpMap2PropName, BumpMap2PropName);

            CopyPropertyToMaterial<Color>(mfxTemplateMaterial, targetMfxMaterial, EmissionColor2PropName, EmissionColor2PropName);
            CopyPropertyToMaterial<Texture>(mfxTemplateMaterial, targetMfxMaterial, EmissionMap2PropName, EmissionMap2PropName);
            CopyPropertyToMaterial<Vector4>(mfxTemplateMaterial, targetMfxMaterial, EmissionMap2ScrollPropName, EmissionMap2ScrollPropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, EmissionSize2PropName, EmissionSize2PropName);
            CopyPropertyToMaterial<bool>(mfxTemplateMaterial, targetMfxMaterial, EmissionSmoothPropName, EmissionSmoothPropName);

            CopyPropertyToMaterial<Color>(mfxTemplateMaterial, targetMfxMaterial, EdgeColorPropName, EdgeColorPropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, EdgeSizePropName, EdgeSizePropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, EdgeStrengthPropName, EdgeStrengthPropName);
            CopyPropertyToMaterial<Texture>(mfxTemplateMaterial, targetMfxMaterial, EdgeRampMap1PropName, EdgeRampMap1PropName);
            CopyPropertyToMaterial<Vector4>(mfxTemplateMaterial, targetMfxMaterial, EdgeRampMap1ScrollPropName, EdgeRampMap1ScrollPropName);
            
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, MaskPropName, MaskPropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, CutoffAxisPropName, CutoffAxisPropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, MaskOffsetPropName, MaskOffsetPropName);

            CopyPropertyToMaterial<Texture>(mfxTemplateMaterial, targetMfxMaterial, DissolveMap1PropName, DissolveMap1PropName);
            CopyPropertyToMaterial<Vector4>(mfxTemplateMaterial, targetMfxMaterial, DissolveMap1ScrollPropName, DissolveMap1ScrollPropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, DissolveSizePropName, DissolveSizePropName);
            CopyPropertyToMaterial<Color>(mfxTemplateMaterial, targetMfxMaterial, DissolveEdgeColorPropName, DissolveEdgeColorPropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, DissolveEdgeSizePropName, DissolveEdgeSizePropName);

            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, FringeSizePropName, FringeSizePropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, FringeAmountPropName, FringeAmountPropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, FringeOffsetPropName, FringeOffsetPropName);
            CopyPropertyToMaterial<Texture>(mfxTemplateMaterial, targetMfxMaterial, FringeRampMapPropName, FringeRampMapPropName);
            CopyPropertyToMaterial<Color>(mfxTemplateMaterial, targetMfxMaterial, FringeColorPropName, FringeColorPropName);
            CopyPropertyToMaterial<Texture>(mfxTemplateMaterial, targetMfxMaterial, FringeEmissionMapPropName, FringeEmissionMapPropName);
            CopyPropertyToMaterial<Vector4>(mfxTemplateMaterial, targetMfxMaterial, FringeEmissionMapScroll, FringeEmissionMapScroll);
            CopyPropertyToMaterial<Color>(mfxTemplateMaterial, targetMfxMaterial, FringeEmissionColorPropName, FringeEmissionColorPropName);

            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, InvertPropName, InvertPropName);
            CopyPropertyToMaterial<float>(mfxTemplateMaterial, targetMfxMaterial, CutoffPropName, CutoffPropName);

            if (determineWorkflow)
            {
                targetMfxMaterial.renderQueue = originalMaterial.renderQueue;
                targetMfxMaterial.SetOverrideTag("RenderType", originalMaterial.GetTag("RenderType", false));
            }
            else
            {
                targetMfxMaterial.renderQueue = mfxTemplateMaterial.renderQueue;
                targetMfxMaterial.SetOverrideTag("RenderType", mfxTemplateMaterial.GetTag("RenderType", false));
            }

            targetMfxMaterial.shaderKeywords = mfxTemplateMaterial.shaderKeywords;
            targetMfxMaterial.SetOverrideTag("Queue", mfxTemplateMaterial.GetTag("Queue", false));
            targetMfxMaterial.SetOverrideTag("IsEmissive", mfxTemplateMaterial.GetTag("IsEmissive", false));
            targetMfxMaterial.SetOverrideTag("PerformanceChecks", mfxTemplateMaterial.GetTag("PerformanceChecks", false));
            targetMfxMaterial.SetOverrideTag("DisableBatching", mfxTemplateMaterial.GetTag("DisableBatching", false));
        }

        private static void CopyPropertyToMaterial<T>(Material fromMaterial, Material toMaterial, string fromProperty, string toProperty)
        {
            if (!fromMaterial.HasProperty(fromProperty))
                return;

            var tType = typeof(T);

            if (tType == typeof(Texture))
            {
                var tex = fromMaterial.GetTexture(fromProperty);
                toMaterial.SetTexture(toProperty, tex);

                var texScale = fromMaterial.GetTextureScale(fromProperty);
                toMaterial.SetTextureScale(toProperty, texScale);
            }
            else if (tType == typeof(Color))
            {
                var col = fromMaterial.GetColor(fromProperty);
                toMaterial.SetColor(toProperty, col);
            }
            else if (tType == typeof(float))
            {
                var f = fromMaterial.GetFloat(fromProperty);
                toMaterial.SetFloat(toProperty, f);
            }
            else if (tType == typeof(int))
            {
                var f = fromMaterial.GetInt(fromProperty);
                toMaterial.SetInt(toProperty, f);
            }
            else if (tType == typeof(Vector4))
            {
                var f = fromMaterial.GetVector(fromProperty);
                toMaterial.SetVector(toProperty, f);
            }
        }

        private static void ReplaceMetallicSpecularKeywords(Material fromMaterial, Material toMaterial)
        {
            var hasMet = fromMaterial.HasProperty("_MetallicGlossMap") && fromMaterial.GetTexture("_MetallicGlossMap") != null;
            var hasSpec = fromMaterial.HasProperty("_SpecGlossMap") && fromMaterial.GetTexture("_SpecGlossMap") != null;
            
            SetKeyword(toMaterial, "_METALLICGLOSSMAP_ON", hasMet);
            SetKeyword(toMaterial, "_SPECGLOSSMAP_ON", hasSpec);

            //lwrp
            SetKeyword(toMaterial, "_METALLICSPECGLOSSMAP_ON", hasMet || hasSpec);
        }
        
        private static void SetKeyword(Material m, string keyword, bool state)
        {
            if (state)
                m.EnableKeyword(keyword);
            else
                m.DisableKeyword(keyword);
        }

        private static string GetShaderByWorkflow(Material material)
        {
            var isMetallic = material.HasProperty("_MetallicGlossMap");
            var isSpecular = material.HasProperty("_SpecGlossMap");

            var isTransparent = material.renderQueue >= (int)RenderQueue.Transparent;

            var isUnlit = material.shader.name.Contains("Unlit");
            
            MfxShaderType mfxShaderType = MfxShaderType.AseUberStandard;

            if (isMetallic && isTransparent)
                mfxShaderType = MfxShaderType.AseUberStandardTransparent;
            else if (isSpecular)
                mfxShaderType = MfxShaderType.AseUberStandardSpecular;
            else if (isUnlit)
                mfxShaderType = MfxShaderType.AseUberStandardUnlit;
            
            return mfxShaderType.GetShaderName();
        }
    }
}
