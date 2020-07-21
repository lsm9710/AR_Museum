using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using UnityEngine.UI;

public class wook_SwitchCam : MonoBehaviour
{
    [SerializeField]
    private Button SwitchCamBtn;

    ARCameraManager ARcamMgr;
    // Start is called before the first frame update

    bool switching = true;

    void Awake()
    {
        SwitchCamBtn.onClick.AddListener(SwitchCam);
        print("done3");

    }

    void Start()
    {
        ARcamMgr = GetComponent<ARCameraManager>();      
        //print(ARcamMgr);
        SwitchCamBtn.GetComponentInChildren<Text>().text = "카메라 전환";

    }

    // Update is called once per frame
    void Update()
    {

    }

    void SwitchCam()
    {
        print("switch 눌림");

        if (switching)
        {
            ARcamMgr.requestedFacingDirection = (CameraFacingDirection)2;

            /* None = 0,
            World = 1,
            User = 2
            */
        }
        else
            ARcamMgr.requestedFacingDirection = (CameraFacingDirection)1;

     
        //print(ARcamMgr.requestedFacingDirection);

        switching = !switching;

        //foreach(ARFace face in arFaceManager.trackables)
        //{
        //    face.enabled = faceTrackingOn;
        //}

        //faceTrackingToggle.GetComponentInChildren<Text>().text = $"Face Tracking {(arFaceManager.enabled ? "Off" : "On" )}";

    }


}

