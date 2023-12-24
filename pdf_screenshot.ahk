#Include Gdip_all.ahk

; 페이지 넘버 suffix
global suffix := 1
; 캡쳐할 윈도우 타이틀
global target_title
; 마지막 페이지
global last_page := 315

image_capture(tit){
    p_path := "C:\Users\pc\Desktop\nest_pdf\" ;저장할 path
    p_file = nestjs_pdf_%suffix% ;저장할 file name
    p_file = %p_file%.png
    p_sum = %p_path%%p_file% ; full path
   
    ; msgbox, %p_path% %p_sum%
    pToken := Gdip_StartUp()
    ;pBitmap := Gdip_BitmapFromHwnd(WinExist(tit))
    pBitmap := Gdip_BitmapFromScreen("384|162|719|929") ; 이곳에 window spy로 얻은 좌표를 넣어준다 //  시작 X|시작 Y |시작X로부터 길이|시작Y로부터 높이

    ; msgbox, %pBitmap%
    Gdip_SaveBitmapToFile(pBitmap, p_sum)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
    suffix := suffix+1
    return
}


;실행
F11::
loop,
    {
    ; 현재 활성 창을 캡처하여 스크린샷을 저장
    CoordMode, Mouse, Relative
    CoordMode, Pixel, Relative
    WinGetActiveStats, Title, Width, Height, X, Y
    CoordMode, Mouse, Screen
    CoordMode, Pixel, Screen
    CoordMode, Mouse, Relative
    CoordMode, Pixel, Relative
    CoordMode, Pixel, Screen
    
    target_title := Title

    image_capture(Title)

    sleep,100
    Send, {Right}
    sleep,1000

    if (suffix > last_page)
        {
            msgbox, Conguraturations! capture complete
            break
        }
    
    }

return

; 종료
F12::
ExitApp
return

