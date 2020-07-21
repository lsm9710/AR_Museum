using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using System;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

//등록한 이미지 정보(이름, 나타날 오브젝트)
[Serializable]
public class MakerImageInfo
{
    //이름
    public string imageName;
    //메인씬에 나타날 오브젝트
    public GameObject showMainObj;
    //메인씬에서 쓰일 오디오
    public AudioClip audioExplanation;
    //게임씬에 나타날 오브젝트
    public GameObject showGameObj;
}
public class GameManager : MonoBehaviour
{
    ARTrackedImageManager trackedImageManager;

    public MakerImageInfo[] imagesInfo;


    //======================

    public Text text;

    public GameObject a;

    // Start is called before the first frame update
    void Start()
    {


        trackedImageManager = GetComponent<ARTrackedImageManager>();

        trackedImageManager.trackedImagesChanged += OnTrackedImageChanged;

        //ObjManager.instance.imageName = "DaboTower";
        //SceneManager.LoadScene("Rally_Main_Scene");

    }

    void OnTrackedImageChanged(ARTrackedImagesChangedEventArgs args)
    {
        ARTrackedImage arTrackedImage;
        for (int i = 0; i < args.updated.Count; i++)
        {
            arTrackedImage = args.updated[i];
            //만약에 트래킹 상태가 기본 상태가 아니면
            if (arTrackedImage.trackingState != TrackingState.None)
            {
                for (int j = 0; j < imagesInfo.Length; j++)
                {
                    //만약에 인식된 이미지 이름이 imageInfos 의 이름과같은놈이 있으면
                    if (arTrackedImage.referenceImage.name == imagesInfo[j].imageName)
                    {
                        ObjManager.instance.imageName = arTrackedImage.referenceImage.name;
                        SceneManager.LoadScene("Rally_Main_Scene");

                        return;
                    }
                }
            }
        }
    }
}
