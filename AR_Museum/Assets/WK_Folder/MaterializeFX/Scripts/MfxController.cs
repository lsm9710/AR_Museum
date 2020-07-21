using System;
using System.Linq;
using UnityEngine;

// ReSharper disable once CheckNamespace
namespace Assets.MaterializeFX.Scripts
{
    public sealed class MfxController : MonoBehaviour
    {
        private const string MfxMaskOffsetProperty = "_MaskOffset";
        private const string MfxWorldPositionOffsetProperty = "_WorldPositionOffset";
        private const string MfxMaskPositionProperty = "_MaskWorldPosition";

        public MaskOffsetDirection MaskOffsetDirection;

        public AnimationCurve MaskOffsetCurve = AnimationCurve.Linear(0f, 0f, 1f, 1f);
        public float ScaleTimeFactor = 1;
        public float ScaleOffsetFactor = 1;
        public bool ModifyChildren = true;
        public GameObject TargetObject;

        public bool ByDistance;
        public GameObject DistanceBasedObject;

        public bool IsWorldPositionOffsetEnabled;

        public bool ReplaceMaterial;
        public bool ReplaceMaterialMode; //Runtime, Editor
        public Material MfxMaterial;
        public MfxShaderType MfxShaderType;

        public bool DetermineWorkflowAutomatically;
        
        public bool AutoDestroy;
        public bool AutoReplace;
        public bool AutoAnimate;

        private float _startTime;
        private bool _isEnabled;
        private MfxObjectMaterialUpdater _mfxObjectMaterialUpdater;
        private Transform _targetTransform;
        private bool _wasEventGenerated;

        public GameObject Target
        {
            get
            {
                return TargetObject != null ? TargetObject : gameObject;
            }
        }

        public Action MfxAnimationFinished;

        public void ReplaceMaterials()
        {
            if (!_mfxObjectMaterialUpdater.IsMaterialsReplaced)
                _mfxObjectMaterialUpdater.Replace(MfxMaterial);
        }

        public void RevertMaterials()
        {
            _mfxObjectMaterialUpdater.Revert();
        }

        public void Reset()
        {
            _startTime = Time.time;
        }

        public void Activate()
        {
            Reset();
            ReplaceMaterials();
            _isEnabled = true;
        }

        public void SetHitPosition(Vector3 hitPositionWorldPos)
        {
            _mfxObjectMaterialUpdater.SetVector("_MaskWorldPosition", hitPositionWorldPos);
        }

        #region Private Methods

        private void Awake()
        {
            _mfxObjectMaterialUpdater = new MfxObjectMaterialUpdater(Target, ModifyChildren, ReplaceMaterial, MfxMaterial, DetermineWorkflowAutomatically, MfxShaderType);
        }

        private void Start()
        {
            _targetTransform = Target.transform;
            _startTime = Time.time;

            if (!AutoAnimate)
                _isEnabled = false;
        }

        private void Update()
        {
            if (_targetTransform == null)
                return;

            if (IsWorldPositionOffsetEnabled)
                _mfxObjectMaterialUpdater.SetVector(MfxWorldPositionOffsetProperty, Target.transform.position);

            if (ByDistance)
            {
                if (DistanceBasedObject == null)
                {
                    Debug.LogError("By distance property was set, but object was not set");
                    return;
                }

                _mfxObjectMaterialUpdater.SetVector(MfxMaskPositionProperty, DistanceBasedObject.transform.position);

                return;
            }

            if (!_isEnabled)
                return;

            var time = (Time.time - _startTime) / ScaleTimeFactor;

            if (MaskOffsetDirection == MaskOffsetDirection.Backward && MaskOffsetCurve.keys.Length != 0)
                time = MaskOffsetCurve.keys.Last().time - time;

            var maskOffset = MaskOffsetCurve.Evaluate(time) * ScaleOffsetFactor;

            if (MaskOffsetCurve.keys.Length != 0)
            {
                var firstCurveTime = MaskOffsetCurve.keys.First();
                var lastCurveTime = MaskOffsetCurve.keys.Last();

                if (!_wasEventGenerated && (time < firstCurveTime.time || time > lastCurveTime.time))
                {
                    _wasEventGenerated = true;

                    if (MfxAnimationFinished != null)
                        MfxAnimationFinished.Invoke();

                    if (AutoReplace)
                        RevertMaterials();

                    if (AutoDestroy)
                        Destroy(gameObject);
                }
            }

            _mfxObjectMaterialUpdater.SetFloat(MfxMaskOffsetProperty, maskOffset);
        }

        private void OnEnable()
        {
            _isEnabled = true;
        }

        private void OnDisable()
        {
            _isEnabled = false;
        }

        #endregion
    }
}