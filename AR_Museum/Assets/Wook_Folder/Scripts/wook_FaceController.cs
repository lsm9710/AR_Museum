using UnityEngine;
using UnityEngine.UI;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR;
using UnityEngine.XR.ARSubsystems;
using UnityEngine.XR.ARCore;

//[RequireComponent(typeof(ARFaceManager))]
public class wook_FaceController : MonoBehaviour
{

    [SerializeField]
    private Button SwitchCamBtn;

    [SerializeField]
    private Button swapFacesToggle;

    ARFaceManager arFaceManager;

    ARCameraManager ARCameraManager;

    bool switching = true;

    private int swapCounter = 0;

    [SerializeField]
    public WookFaceMaterial[] materials;




    void Awake()
    {

        //UnityEngine.XR.ARFoundation.SubsystemLifecycleManager<UnityEngine.XR.ARSubsystems.XRFaceSubsystem,
        //    UnityEngine.XR.ARSubsystems.XRFaceSubsystemDescriptor>.OnBeforeStart();

       

        arFaceManager = GameObject.Find("AR Session Origin").GetComponent<ARFaceManager>();
        //print("done1");

        ARCameraManager = GameObject.Find("AR Camera").GetComponent<ARCameraManager>();


        swapFacesToggle.onClick.AddListener(SwapFaces);
        //print("done3");

        SwitchCamBtn.onClick.AddListener(SwitchCam);

        SwitchCamBtn.GetComponentInChildren<Text>().text = "카메라 전환";

        arFaceManager.facePrefab.GetComponent<MeshRenderer>().material = materials[0].Material;
        //print("done4");

    }

    void SwapFaces() 
    {
        print("swap face 눌림");
        swapCounter = swapCounter == materials.Length - 1 ? 0 : swapCounter + 1;
        
        foreach(ARFace face in arFaceManager.trackables)
        {
            face.GetComponent<MeshRenderer>().material = materials[swapCounter].Material;
        }

        swapFacesToggle.GetComponentInChildren<Text>().text = $"Face Material ({materials[swapCounter].Name})";
    }

    void SwitchCam()
    {
        print("switch 눌림");

        if (switching)
        {
            ARCameraManager.requestedFacingDirection = (CameraFacingDirection)2;

            /* None = 0,
            World = 1,
            User = 2
            */
        }
        else
            ARCameraManager.requestedFacingDirection = (CameraFacingDirection)1;


        //print(ARcamMgr.requestedFacingDirection);

        switching = !switching;

        //foreach(ARFace face in arFaceManager.trackables)
        //{
        //    face.enabled = faceTrackingOn;
        //}

        //faceTrackingToggle.GetComponentInChildren<Text>().text = $"Face Tracking {(arFaceManager.enabled ? "Off" : "On" )}";

    }



}



[System.Serializable]
public class WookFaceMaterial
{
    public Material Material;

    public string Name;
}
