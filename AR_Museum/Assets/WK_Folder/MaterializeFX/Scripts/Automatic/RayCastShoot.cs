﻿using System.Collections;
using UnityEngine;

// ReSharper disable once CheckNamespace
namespace Assets.MaterializeFX
{
    internal class RayCastShoot : MonoBehaviour
    {

        public float FireRate = 0.25f;
        public float WeaponRange = 50f;
        public float HitForce = 100f;
        public Transform GunEnd;

        public MfxAutomaticRayCastSource MfxAutomaticRayCastSource;

        private Camera _fpsCam;
        private readonly WaitForSeconds _shotDuration = new WaitForSeconds(0.07f); 
        private LineRenderer _laserLine;                                        
        private float _nextFire;                                             


        private void Start()
        {
            _laserLine = GetComponent<LineRenderer>();
            _fpsCam = GetComponentInParent<Camera>();
        }


        private void Update()
        {
            if (Input.GetButtonDown("Fire1") && Time.time > _nextFire)
            {
                if (MfxAutomaticRayCastSource != null)
                    MfxAutomaticRayCastSource.Emit();

                _nextFire = Time.time + FireRate;

                StartCoroutine(ShotEffect());

                var rayOrigin = _fpsCam.ViewportToWorldPoint(new Vector3(0.5f, 0.5f, 0.0f));

                RaycastHit hit;

                _laserLine.SetPosition(0, GunEnd.position);

                if (Physics.Raycast(rayOrigin, _fpsCam.transform.forward, out hit, WeaponRange))
                {
                    _laserLine.SetPosition(1, hit.point);

                    if (hit.rigidbody != null)
                        hit.rigidbody.AddForce(-hit.normal * HitForce);
                }
                else
                    _laserLine.SetPosition(1, rayOrigin + (_fpsCam.transform.forward * WeaponRange));
            }
        }

        private IEnumerator ShotEffect()
        {
            _laserLine.enabled = true;
            yield return _shotDuration;
            _laserLine.enabled = false;
        }
    }
}