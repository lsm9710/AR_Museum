using Assets.MaterializeFX.Scripts;
using UnityEngine;

// ReSharper disable once CheckNamespace
namespace Assets.MaterializeFX
{
    [RequireComponent(typeof(MfxController))]
    internal class MfxAutomatic : MonoBehaviour
    {
        private MfxController _mfxController;
        private bool _isProcessing;

        public void Activate(Vector3 hitWorldPos)
        {
            if (_isProcessing)
                return;

            _isProcessing = true;
            _mfxController.Activate();
            _mfxController.SetHitPosition(hitWorldPos);
        }

        private void Awake()
        {
            _mfxController = GetComponent<MfxController>();
        }
    }
}
