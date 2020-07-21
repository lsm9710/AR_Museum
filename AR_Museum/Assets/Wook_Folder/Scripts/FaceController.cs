using UnityEngine;
using UnityEngine.UI;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR;
using UnityEngine.XR.ARSubsystems;
using UnityEngine.XR.ARCore;

[RequireComponent(typeof(ARFaceManager))]
public class FaceController : MonoBehaviour
{
    

    [SerializeField]
    private Button faceTrackingToggle;

    [SerializeField]
    private Button swapFacesToggle;

    private ARFaceManager arFaceManager;

    ARCameraManager ARCameraManager;

    private bool faceTrackingOn = true;

    private int swapCounter = 0;

    [SerializeField]
    public FaceMaterial[] materials;

    


    void Awake()
    {

        //UnityEngine.XR.ARFoundation.SubsystemLifecycleManager<UnityEngine.XR.ARSubsystems.XRFaceSubsystem,
        //    UnityEngine.XR.ARSubsystems.XRFaceSubsystemDescriptor>.OnBeforeStart();

        

        arFaceManager = GetComponent<ARFaceManager>();
        print("done1");

        faceTrackingToggle.onClick.AddListener(ToggleTrackingFaces);
        print("done2");

        swapFacesToggle.onClick.AddListener(SwapFaces);
        print("done3");

        arFaceManager.facePrefab.GetComponent<MeshRenderer>().material = materials[0].Material;
        print("done4");

    }

    void SwapFaces() 
    {
        print("눌림");
        swapCounter = swapCounter == materials.Length - 1 ? 0 : swapCounter + 1;
        
        foreach(ARFace face in arFaceManager.trackables)
        {
            face.GetComponent<MeshRenderer>().material = materials[swapCounter].Material;
        }

        swapFacesToggle.GetComponentInChildren<Text>().text = $"Face Material ({materials[swapCounter].Name})";
    }

    void ToggleTrackingFaces() 
    { 
        faceTrackingOn = !faceTrackingOn;

        if(faceTrackingOn)
        {
            ARCameraManager.requestedFacingDirection = (CameraFacingDirection)2;

        /* None = 0,
        World = 1,
        User = 2
        */
        }
        else
        ARCameraManager.requestedFacingDirection = (CameraFacingDirection)1;

        //foreach(ARFace face in arFaceManager.trackables)
        //{
        //    face.enabled = faceTrackingOn;
        //}

        //faceTrackingToggle.GetComponentInChildren<Text>().text = $"Face Tracking {(arFaceManager.enabled ? "Off" : "On" )}";
        faceTrackingToggle.GetComponentInChildren<Text>().text = "카메라 전환";
    }

    


}



[System.Serializable]
public class FaceMaterial
{
    public Material Material;

    public string Name;
}
 