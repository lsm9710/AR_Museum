using UnityEngine;

// ReSharper disable once CheckNamespace
namespace Assets.MaterializeFX
{
    internal sealed class MfxAutomaticRayCastSource : MonoBehaviour
    {
        public float RayCastRange;

        public Camera Camera;

        public void Emit()
        {
            var rayOrigin = Camera.ViewportToWorldPoint(new Vector3(0.5f, 0.5f, 0.0f));

            RaycastHit hit;

            if (Physics.Raycast(rayOrigin, Camera.transform.forward, out hit, RayCastRange))
            {
                var automatic = hit.collider.GetComponent<MfxAutomatic>();
                if (automatic == null)
                    return;

                automatic.Activate(hit.point);
            }
        }
    }
}
