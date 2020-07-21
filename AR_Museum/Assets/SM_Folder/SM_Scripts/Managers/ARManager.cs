using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
//카메라에서 레이를 발사해서 부딪히는 곳에 화살표 보이게 하고 싶다.
public class ARManager : MonoBehaviour
{
    //화살표
    public GameObject arrow;
    //자동차 공장 주소
    public GameObject carFactory;
    //ARRaycastManager
    ARRaycastManager arRayManager;
    //화면 중앙
    Vector2 viewCenter;
    //Ground
    public GameObject ground;

    // Start is called before the first frame update
    void Start()
    {
#if UNITY_EDITOR
#else
        ground.SetActive(false);
        arRayManager = GetComponent<ARRaycastManager>();
        viewCenter.x = Screen.width * 0.5f;
        viewCenter.y = Screen.height * 0.5f;
#endif
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 pos;
#if UNITY_EDITOR
        //Ray 만들자

        Ray ray = new Ray(Camera.main.transform.position, Camera.main.transform.forward);
        //만약에 레이거 어딘가에 부딪히면
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit))
        {
            pos = hit.point;
#else
        List<ARRaycastHit> hits = new List<ARRaycastHit>();
        if(arRayManager.Raycast(viewCenter, hits))
        {
            pos = hits[0].pose.position;
#endif
            //화살표를 그 위치에 보이게 하고 싶다.
            arrow.SetActive(true);
            arrow.transform.position = pos;
        }
        //부딪히지 않았다면
        else
        {
            //화살표를 끄자
            arrow.SetActive(false);
        }

        //만약 마우스 왼쪽버튼을 누르면
        if (Input.GetMouseButtonDown(0))
        {
            //만약에 애로우가 활성화 되어있다면
            if (arrow.activeSelf == true)
            {
                //자동차를 생성해서 화살표 위치에 놓고 싶다.
                GameObject car = Instantiate(carFactory);
                car.transform.position = arrow.transform.position;
            }
        }
    }
}
