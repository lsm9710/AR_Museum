using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

//이미지 정보 (이름, 보여줄 오브젝트)
public class ImageInfo
{
    public string imageName;
    public GameObject showObj;
}


public class MarkerImages : MonoBehaviour
{
    ARTrackedImageManager trackedImageManager;
    // Start is called before the first frame update
    void Start()
    {
        trackedImageManager = GetComponent < ARTrackedImageManager > ();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
