(* this file is machine generated! - not change this! *)
(* Этот файл сгенерирован программой! не меняйте его руками! *)
(* Для правки нужно использовать исходник *.vsd и программу генерации (запустите скрипт build_all.bat). *)
(* Автор шаблона генератора: Кернер А.В. 2018 год. *)
(* Программа генератор: metaAuto. Автор: Канжелев С.Ю. 2005 год. *)
(* Model:Visio project *)
(* Automat: Algo *)
(*  *)
CASE StateAlgo OF 

0: (* Инициализация *)

  (* Условия перехода: *)
  IF (NOT(DataIn.U)) THEN
    StateAlgo := 66; RETURN;
  END_IF;
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (((NOT(DataIn.KVO)) AND (DataIn.KVZ)) AND (DataIn.T01)) THEN
    StateAlgo := 1; RETURN;
  END_IF;
  IF ((DataIn.KVZ) AND (DataIn.MPZ)) THEN
    StateAlgo := 14; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (NOT(DataIn.KVZ))) AND (DataIn.T01)) THEN
    StateAlgo := 2; RETURN;
  END_IF;
  IF ((DataIn.KVO) AND (DataIn.MPO)) THEN
    StateAlgo := 24; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (DataIn.KVZ)) AND (DataIn.T01)) THEN
    StateAlgo := 3; RETURN;
  END_IF;

1: (* Открыта *)
  (* Выходные данные: *)
  DataOut.F_Opened := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Close) AND (DataIn.Dist)) THEN
    StateAlgo := 11; RETURN;
  END_IF;
  IF (DataIn.MPZ) THEN
    StateAlgo := 17; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (DataIn.KVZ)) AND (DataIn.T01)) THEN
    StateAlgo := 3; RETURN;
  END_IF;

11: (* Формирование команды закрытия *)
  (* Выходные данные: *)
  DataOut.Out_Close := TRUE;
  DataOut.F_Closing := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (DataIn.MPZ) THEN
    StateAlgo := 12; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Open) AND (DataIn.Dist)) THEN
    StateAlgo := 41; RETURN;
  END_IF;
  IF ((DataIn.T02) AND (DataIn.Dist)) THEN
    StateAlgo := 62; RETURN;
  END_IF;

12: (* Сход с концевика (закрытие) *)
  (* Выходные данные: *)
  DataOut.F_Closing := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF ((DataIn.MPZ) AND (DataIn.KVO)) THEN
    StateAlgo := 14; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Open) AND (DataIn.Dist)) THEN
    StateAlgo := 41; RETURN;
  END_IF;
  IF ((DataIn.T03) AND (DataIn.Dist)) THEN
    StateAlgo := 62; RETURN;
  END_IF;

14: (* Закрывается *)
  (* Выходные данные: *)
  DataOut.F_Closing := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (NOT(DataIn.KVZ))) AND (NOT(DataIn.MPZ))) THEN
    StateAlgo := 2; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Open) AND (DataIn.Dist)) THEN
    StateAlgo := 41; RETURN;
  END_IF;
  IF ((DataIn.T04) AND (DataIn.Dist)) THEN
    StateAlgo := 62; RETURN;
  END_IF;

17: (* Закрывается сама *)
  (* Выходные данные: *)
  DataOut.F_Closing := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (NOT(DataIn.KVZ))) AND (NOT(DataIn.MPZ))) THEN
    StateAlgo := 2; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (DataIn.KVZ)) AND (NOT(DataIn.MPZ))) THEN
    StateAlgo := 3; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Open) AND (DataIn.Dist)) THEN
    StateAlgo := 41; RETURN;
  END_IF;

2: (* Закрыта *)
  (* Выходные данные: *)
  DataOut.F_Closed := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Open) AND (DataIn.Dist)) THEN
    StateAlgo := 21; RETURN;
  END_IF;
  IF (DataIn.MPZ) THEN
    StateAlgo := 27; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (DataIn.KVZ)) AND (DataIn.T01)) THEN
    StateAlgo := 3; RETURN;
  END_IF;

21: (* Формирование команды открытия *)
  (* Выходные данные: *)
  DataOut.Out_Open := TRUE;
  DataOut.F_Opening := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (DataIn.MPO) THEN
    StateAlgo := 22; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Close) AND (DataIn.Dist)) THEN
    StateAlgo := 42; RETURN;
  END_IF;
  IF ((DataIn.T02) AND (DataIn.Dist)) THEN
    StateAlgo := 61; RETURN;
  END_IF;

22: (* Сход с концевика (открытие) *)
  (* Выходные данные: *)
  DataOut.F_Opening := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF ((DataIn.MPO) AND (DataIn.KVZ)) THEN
    StateAlgo := 24; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Close) AND (DataIn.Dist)) THEN
    StateAlgo := 42; RETURN;
  END_IF;
  IF ((DataIn.T03) AND (DataIn.Dist)) THEN
    StateAlgo := 61; RETURN;
  END_IF;

24: (* Открывается *)
  (* Выходные данные: *)
  DataOut.F_Opening := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (((NOT(DataIn.KVO)) AND (DataIn.KVZ)) AND (NOT(DataIn.MPO))) THEN
    StateAlgo := 1; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Close) AND (DataIn.Dist)) THEN
    StateAlgo := 42; RETURN;
  END_IF;
  IF ((DataIn.T04) AND (DataIn.Dist)) THEN
    StateAlgo := 61; RETURN;
  END_IF;

27: (* Открывается сама *)
  (* Выходные данные: *)
  DataOut.F_Opening := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (((NOT(DataIn.KVO)) AND (DataIn.KVZ)) AND (NOT(DataIn.MPZ))) THEN
    StateAlgo := 1; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (DataIn.KVZ)) AND (NOT(DataIn.MPO))) THEN
    StateAlgo := 3; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Close) AND (DataIn.Dist)) THEN
    StateAlgo := 42; RETURN;
  END_IF;

3: (* В промежутке *)
  (* Выходные данные: *)
  DataOut.F_Between := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (((NOT(DataIn.KVO)) AND (DataIn.KVZ)) AND (DataIn.T01)) THEN
    StateAlgo := 1; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Close) AND (DataIn.Dist)) THEN
    StateAlgo := 11; RETURN;
  END_IF;
  IF (DataIn.MPZ) THEN
    StateAlgo := 17; RETURN;
  END_IF;
  IF (((DataIn.KVO) AND (NOT(DataIn.KVZ))) AND (DataIn.T01)) THEN
    StateAlgo := 2; RETURN;
  END_IF;
  IF ((DataIn.Cmd_Open) AND (DataIn.Dist)) THEN
    StateAlgo := 21; RETURN;
  END_IF;
  IF (DataIn.MPO) THEN
    StateAlgo := 27; RETURN;
  END_IF;
  IF (NOT(DataIn.U)) THEN
    StateAlgo := 66; RETURN;
  END_IF;

40: (* Стоп! *)
  (* Выходные данные: *)
  DataOut.Out_Stop := TRUE;

  (* Условия перехода: *)
  IF (((NOT(DataIn.MPO)) AND (NOT(DataIn.MPZ))) AND (DataIn.T08)) THEN
    StateAlgo := 401; RETURN;
  END_IF;

401: (* Стабилизация после стопа *)

  (* Условия перехода: *)
  IF ((DataIn.T01) AND (DataIn.U)) THEN
    StateAlgo := 0; RETURN;
  END_IF;

41: (* Стоп и потом открытие *)
  (* Выходные данные: *)
  DataOut.Out_Stop := TRUE;

  (* Условия перехода: *)
  IF (((NOT(DataIn.MPO)) AND (NOT(DataIn.MPZ))) AND (DataIn.T08)) THEN
    StateAlgo := 411; RETURN;
  END_IF;

411: (* Стабилизация после стопа *)

  (* Условия перехода: *)
  IF ((DataIn.T01) AND (DataIn.U)) THEN
    StateAlgo := 21; RETURN;
  END_IF;

42: (* Стоп и потом закрытие *)
  (* Выходные данные: *)
  DataOut.Out_Stop := TRUE;

  (* Условия перехода: *)
  IF (((NOT(DataIn.MPO)) AND (NOT(DataIn.MPZ))) AND (DataIn.T08)) THEN
    StateAlgo := 421; RETURN;
  END_IF;

421: (* Стабилизация после стопа *)

  (* Условия перехода: *)
  IF ((DataIn.T01) AND (DataIn.U)) THEN
    StateAlgo := 11; RETURN;
  END_IF;

460: (* Стабилизация после стопа *)
  (* Выходные данные: *)
  DataOut.F_Error := TRUE;

  (* Условия перехода: *)
  IF ((DataIn.T01) AND (DataIn.U)) THEN
    StateAlgo := 666; RETURN;
  END_IF;

6: (* Авария (Ошибка) *)
  (* Выходные данные: *)
  DataOut.F_Error := TRUE;
  DataOut.Out_Stop := TRUE;

  (* Условия перехода: *)
  IF (DataIn.T08) THEN
    StateAlgo := 460; RETURN;
  END_IF;

61: (* Не выполнение команды открытия *)
  (* Выходные данные: *)
  DataOut.F_Error := TRUE;
  DataOut.Out_Stop := TRUE;

  (* Условия перехода: *)
  IF (DataIn.T08) THEN
    StateAlgo := 460; RETURN;
  END_IF;

62: (* Не выполнение команды закрытия *)
  (* Выходные данные: *)
  DataOut.F_Error := TRUE;
  DataOut.Out_Stop := TRUE;

  (* Условия перехода: *)
  IF (DataIn.T08) THEN
    StateAlgo := 460; RETURN;
  END_IF;

63: (* Не выполнение команды стоп *)
  (* Выходные данные: *)
  DataOut.F_Error := TRUE;
  DataOut.Out_Stop := TRUE;

  (* Условия перехода: *)
  IF (DataIn.T08) THEN
    StateAlgo := 460; RETURN;
  END_IF;

66: (* Нет напряжения в схеме управления *)

  (* Условия перехода: *)
  IF (DataIn.Cmd_Stop) THEN
    StateAlgo := 40; RETURN;
  END_IF;
  IF (DataIn.U) THEN
    StateAlgo := 0; RETURN;
  END_IF;

666: (* Ожидаем деблокировки *)
  (* Выходные данные: *)
  DataOut.F_Error := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Cmd_Deblock) THEN
    StateAlgo := 0; RETURN;
  END_IF;
END_CASE; (* *)(* End. *)