%% Info
% 概要：AlexNetを用いて、カメラからリアルタイムに予測するスクリプト
% 用途：ディープラーニングの理解のため
% @author 2019/4/10 [Masumi Morishige]

%% リセットプログラム
clc;
close all;
clear;

%% GUIの作成
screen_size = get(0, 'ScreenSize');
fig = figure('Name', 'Image_AI', 'NumberTitle', 'off', 'position', [screen_size(3)/2-500,screen_size(4)/2-500, 1000, 1000], 'MenuBar', 'none');
app_switch = true;
UI_Start = uicontrol(gcf, 'Style', 'Push', 'Position', [400 10 200 80], 'String', 'Stop', 'FontSize', 30, 'Callback', 'app_switch = false;');

%% 変数などの設定
% ニューラルネットワークの読み込み
net = googlenet;
class_names = net.Layers(end).ClassNames;
cam = webcam;

%% 予測の処理
while app_switch
    pic = cam.snapshot;
    image(pic);
    pic = imresize(pic, [224 224]);
    [label, score] = classify(net, pic);
    view = string(label) + '(' + num2str(100*score(class_names == label),2) + '%)';
    UI_Prediction = uicontrol(gcf, 'Style', 'Text', 'Position', [200 940 600 50], 'String', string(label) + '(' + num2str(100*score(class_names == label),2) + '%)', 'FontSize', 40, 'BackGroundColor', [0.8 0.8 0.8]);
    drawnow;
end

close;

%% End of the Script
