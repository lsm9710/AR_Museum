using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using UnityEngine.UI;

public class wook_testP : MonoBehaviour
{

    ARFaceManager arFaceMgr;
    public Text logText;
   
    // Start is called before the first frame update
    void Start()
    {
        //arFaceMgr.requestedMaximumFaceCount = 3;
        arFaceMgr = GetComponent<ARFaceManager>();
        arFaceMgr.requestedMaximumFaceCount = 3;
        //arFaceMgr.maximumFaceCount =2;

        arFaceMgr.facesChanged += OnFaceChanged;
        
    }

    void OnFaceChanged(ARFacesChangedEventArgs args)
    {
        List<ARFace> addFace = args.added;
        List<ARFace> updateFace = args.updated;
        List<ARFace> removeFace = args.removed;

        logText.text = "";
        
        for (int i = 0; i < updateFace.Count; i++)
        {
            if (updateFace[i].trackingState == TrackingState.Tracking)
            {
                //logText.text += string.Format("\r\ntracking Face id: {0}", updateFace[i].trackableId);
                //logText.text += ("add" + (addFace.Count)).ToString();
                //오브젝트 id 이기때문에 count로 찍어보기.
                //logText.text += ("updated" + (updateFace.Count)).ToString();
                //logText.text += ("remove" + (updateFace.Count)).ToString();
            }


        }

        logText.text += ("added" + (addFace.Count)).ToString();
        logText.text += ("\r\nupdate" + (updateFace.Count)).ToString();
        logText.text += ("\r\nremove" + (removeFace.Count)).ToString();

        //print(updateFace.Count);
    }

    // Update is called once per frame
    void Update()
    {
        //print("faceManager requested :"+ arFaceMgr.requestedMaximumFaceCount);
        //print("faceManager supported :"+ arFaceMgr.supportedFaceCount);


        //print("faceManager cuurentmax" + arFaceMgr.currentMaximumFaceCount);
        //print("add lis : " );

        //print("sub requested"+ sub.requestedMaximumFaceCount);
        //print("supported face" + sub.supportedFaceCount);
        //arFaceMgr.requestedMaximumFaceCount = 3;
        if (Input.anyKey)
        {
            logText.text = "";
        }

    }

}
