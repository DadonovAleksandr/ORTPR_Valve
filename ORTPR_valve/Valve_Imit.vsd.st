(* this file is machine generated! - not change this! *)
(* Этот файл сгенерирован программой! не меняйте его руками! *)
(* Для правки нужно использовать исходник *.vsd и программу генерации (запустите скрипт build_all.bat). *)
(* Автор шаблона генератора: Кернер А.В. 2018 год. *)
(* Программа генератор: metaAuto. Автор: Канжелев С.Ю. 2005 год. *)
(* Model:Visio project *)
(* Automat: ValveImit *)
(*  *)
CASE StateValveImit OF 

0: (* Инициализация *)

  (* Условия перехода: *)
  IF (TRUE) THEN
    StateValveImit := 10; RETURN;
  END_IF;

10: (* Открыта *)
  (* Выходные данные: *)
  DataOut.KVO := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Out_Close) THEN
    StateValveImit := 11; RETURN;
  END_IF;
  IF (DataIn.Out_Stop) THEN
    StateValveImit := 33; RETURN;
  END_IF;

11: (* Закрывается *)
  (* Выходные данные: *)
  DataOut.MPZ := TRUE;

  (* Условия перехода: *)
  IF (DataIn.T[04]) THEN
    StateValveImit := 20; RETURN;
  END_IF;
  IF (DataIn.Out_Stop) THEN
    StateValveImit := 31; RETURN;
  END_IF;

20: (* Закрыта *)
  (* Выходные данные: *)
  DataOut.KVZ := TRUE;

  (* Условия перехода: *)
  IF (DataIn.Out_Open) THEN
    StateValveImit := 21; RETURN;
  END_IF;
  IF (DataIn.Out_Stop) THEN
    StateValveImit := 32; RETURN;
  END_IF;

21: (* Открывается *)
  (* Выходные данные: *)
  DataOut.MPO := TRUE;

  (* Условия перехода: *)
  IF (DataIn.T[04]) THEN
    StateValveImit := 10; RETURN;
  END_IF;
  IF (DataIn.Out_Stop) THEN
    StateValveImit := 31; RETURN;
  END_IF;

30: (* Промежуток *)

  (* Условия перехода: *)
  IF (DataIn.Out_Close) THEN
    StateValveImit := 11; RETURN;
  END_IF;
  IF (DataIn.Out_Open) THEN
    StateValveImit := 21; RETURN;
  END_IF;
  IF (DataIn.Out_Stop) THEN
    StateValveImit := 31; RETURN;
  END_IF;

31: (* Стоп *)

  (* Условия перехода: *)
  IF (NOT(DataIn.Out_Stop)) THEN
    StateValveImit := 30; RETURN;
  END_IF;

32: (* Стоп *)

  (* Условия перехода: *)
  IF (NOT(DataIn.Out_Stop)) THEN
    StateValveImit := 20; RETURN;
  END_IF;

33: (* Стоп *)

  (* Условия перехода: *)
  IF (NOT(DataIn.Out_Stop)) THEN
    StateValveImit := 10; RETURN;
  END_IF;
END_CASE; (* *)(* End. *)