// ReSharper disable once CheckNamespace
namespace Assets.MaterializeFX.Scripts
{
    internal static class MfxExtensions
    {
        private const string MfxAseStandardShaderName = "QFX/MFX/ASE/Uber/Standard";
        private const string MfxAseStandardSpecularShaderName = "QFX/MFX/ASE/Uber/Standard Specular";
        private const string MfxAseStandardTransparentShaderName = "QFX/MFX/ASE/Uber/Standard Transparent";
        private const string MfxAseUnlitShaderName = "QFX/MFX/ASE/Uber/Unlit";

        public static string GetShaderName(this MfxShaderType mfxShaderType)
        {
            switch (mfxShaderType)
            {
                case MfxShaderType.AseUberStandard:
                    return MfxAseStandardShaderName;
                case MfxShaderType.AseUberStandardSpecular:
                    return MfxAseStandardSpecularShaderName;
                case MfxShaderType.AseUberStandardTransparent:
                    return MfxAseStandardTransparentShaderName;
                case MfxShaderType.AseUberStandardUnlit:
                    return MfxAseUnlitShaderName;
                default:
                    return MfxAseUnlitShaderName;
            }
        }
    }
}