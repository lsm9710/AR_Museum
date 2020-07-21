using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LookRotateCamera : MonoBehaviour
{
    GameObject my_camera;
    // Start is called before the first frame update
    void Start()
    {
        my_camera = GameObject.FindGameObjectWithTag("MainCamera");
    }

    // Update is called once per frame
    void Update()
    {
        if (my_camera != null)
        {
            transform.LookAt(transform.position + my_camera.transform.rotation * Vector3.forward,
            my_camera.transform.rotation * Vector3.up);
        }
    }
}
