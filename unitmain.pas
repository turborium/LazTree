unit unitMain;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TFormTree }

  TFormTree = class(TForm)
    Timer: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    Time: Double;
  public

  end;

var
  FormTree: TFormTree;

implementation

{$R *.lfm}

type

  { TPointFloat }

  TPointFloat = record
    X: Double;
    Y: Double;
    constructor Create(X, Y: Double);
  end;

  { TPointFloat }

  constructor TPointFloat.Create(X, Y: Double);
  begin
    Self.X := X;
    Self.Y := Y;
  end;

procedure DrawTree(Canvas: TCanvas;// канва где рисуем
  StartPoint: TPointFloat;// начальная позиция ветки
  LineLength: Double;// длина ветки
  Angle: Double;// угол ветки
  DeltaAngle: Double// дельта угла ветки
  );
var
  EndPoint: TPointFloat;
  NewLength: Double;
begin
  EndPoint.Y := StartPoint.Y - LineLength * Cos(Angle + DeltaAngle);
  EndPoint.X := StartPoint.X + LineLength * Sin(Angle + DeltaAngle);

  Canvas.MoveTo(Trunc(StartPoint.X), Trunc(StartPoint.Y));
  Canvas.LineTo(Trunc(EndPoint.X), Trunc(EndPoint.Y));

  NewLength := LineLength * 0.7;
  if NewLength >= 4 then
  begin
    DrawTree(Canvas, EndPoint, NewLength, Angle + PI/4 + DeltaAngle, DeltaAngle);
    DrawTree(Canvas, EndPoint, NewLength, Angle - PI/4 + DeltaAngle, DeltaAngle);
  end;
end;

{ TFormTree }

procedure TFormTree.FormPaint(Sender: TObject);
begin
  Canvas.Pen.Width := 2;
  DrawTree(
    Self.Canvas,
    TPointFloat.Create(Self.ClientWidth / 2, Self.ClientHeight),
    150,
    0,// изначально угол ветки = 0 => растет вверх
    0.3 * Sin(Time)
  );
end;

procedure TFormTree.TimerTimer(Sender: TObject);
begin
  Time := Time + 0.07;
  Invalidate;
end;

end.

