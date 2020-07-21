using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.Android;

//카메라에서 레이 발사, 부딪히는 곳에 화살표 보이게. 

public class wook_ARCamManager : MonoBehaviour
{
    public GameObject arrow;

    public GameObject carFactory;

    public GameObject dialog =null;

    Vector3 pos;
    ARRaycastManager aRRaycastManager;

    //화면중앙 설정
    Vector2 viewCenter;

    public GameObject ground;


    // Start is called before the first frame update
    void Start()
    {

        //pc 테스트
#if UNITY_EDITOR

        //android 테스트
#else
        ground.SetActive(false);
        aRRaycastManager = GetComponent<ARRaycastManager>();
        viewCenter.x = Screen.width * 0.5f;
        viewCenter.y = Screen.height * 0.5f;
        //if (!Permission.HasUserAuthorizedPermission(Permission.Microphone))
        //{
        //    Permission.RequestUserPermission(Permission.Microphone);
        //    dialog = new GameObject();
        //}
      
#endif
    }


    // Update is called once per frame
    void Update()
     {
            //pc 테스트
#if UNITY_EDITOR
            //Ray 만들기 
            Ray ray = new Ray(Camera.main.transform.position, Camera.main.transform.forward);
            RaycastHit hit;
        //만약 ray가 어딘가에 부딪힘
        if (Physics.Raycast(ray, out hit))
        {
            pos = hit.point;

            print(hit.collider);

            arrow.SetActive(true);
            arrow.transform.position = pos;
        }

        //android 테스트
#else
        List<ARRaycastHit> hits = new List<ARRaycastHit>();
        if (aRRaycastManager.Raycast(viewCenter, hits))
        {
            pos = hits[0].pose.position;
            //print("레이다...");
            //화살표를 그위치에 보이게.
            arrow.SetActive(true);
            arrow.transform.position = pos;
        }

#endif



        //안부딪히면
        else
        {
            //화살표 끈다.
            arrow.SetActive(false);

        }

            //만약 마우스 왼쪽버튼을 누르면 
            //자동차를 생성.
            //화살표 위치에 놓는다



        //if (Input.GetMouseButton(0)) // Android 터치 다운과 같다
        //{
        //    if (arrow.activeSelf == true)
        //    {
        //        GameObject car = Instantiate(carFactory);
        //        car.transform.position = arrow.transform.position;

        //    }
        //}

        

     }

    private void OnDrawGizmos()
    {
        #if UNITY_EDITOR
                Gizmos.color = Color.green;
                Gizmos.DrawLine(Camera.main.transform.position, Camera.main.transform.forward);
        #else
        #endif
    }
}
 