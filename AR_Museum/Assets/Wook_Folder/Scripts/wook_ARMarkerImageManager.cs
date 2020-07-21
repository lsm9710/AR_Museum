using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using UnityEngine.SceneManagement;

//전역 변수만 가지는 클래스. 클래스만 가지면 외부에서 접근이 불가하기에
//Serializable 넣음.
[System.Serializable]
public class Wook_ImageInfo
{
    public string imagName;
    public GameObject showObj;
}





public class wook_ARMarkerImageManager : MonoBehaviour
{


    ARTrackedImageManager trackedImageManager;


    public Wook_ImageInfo[] imageInfos;
    


    // Start is called before the first frame update
    void Start()
    {
        trackedImageManager = GetComponent<ARTrackedImageManager>();

        //이미지 인식이되면 호출되는 함수 등록
        trackedImageManager.trackedImagesChanged += OnTrackedImagesChanged;

    }

    // Update is called once per frame
    void Update()
    {
      
        

    }

    void OnTrackedImagesChanged(ARTrackedImagesChangedEventArgs args)
    {
        ARTrackedImage trackedImage;
        for (int i = 0; i < args.updated.Count; i++)
        {
            trackedImage = args.updated[i];
            ///만약에 트랙킹 상태가 기본상태가 아니면 
            if(trackedImage.trackingState != TrackingState.None)
            {
                //만약 인식된 이미지 이름이 imagInfos의 이름과 같은 놈이 있으면
                for(int j =0; j<imageInfos.Length; j++)
                {
                    if(trackedImage.referenceImage.name == imageInfos[j].imagName)
                    {

                        //ObjManager.instance.imageName = imageInfos[j].imagName;
                        //SceneManager.LoadScene("Wook_AudioScene");

                        //해당 오브젝트를 보여주자 
                        imageInfos[j].showObj.SetActive(true);
                        //Instantiate(imageInfos[j].showObj);
                        Vector3 pos = trackedImage.transform.position + Vector3.right;
                        imageInfos[j].showObj.transform.position = pos;
                        //imageInfos[j].showObj.transform.position = trackedImage.transform.position;

                        if (imageInfos[j].imagName == "DifferencePic_Orgin 1")
                        {
                            imageInfos[j].showObj.transform.forward = Camera.main.transform.forward;
                            break;
                        }
                        imageInfos[j].showObj.transform.forward = -Camera.main.transform.forward;

                        break;
                    }
                }
            }

        }

        
    }
}
