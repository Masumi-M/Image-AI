%% Info
% �T�v�FAlexNet��p���āA�J�������烊�A���^�C���ɗ\������X�N���v�g
% �p�r�F�f�B�[�v���[�j���O�̗����̂���
% @author 2019/4/10 [Masumi Morishige]

%% ���Z�b�g�v���O����
clc;
close all;
clear;

%% GUI�̍쐬
screen_size = get(0, 'ScreenSize');
fig = figure('Name', 'Image_AI', 'NumberTitle', 'off', 'position', [screen_size(3)/2-500,screen_size(4)/2-500, 1000, 1000], 'MenuBar', 'none');
app_switch = true;
UI_Start = uicontrol(gcf, 'Style', 'Push', 'Position', [400 10 200 80], 'String', 'Stop', 'FontSize', 30, 'Callback', 'app_switch = false;');

%% �ϐ��Ȃǂ̐ݒ�
% �j���[�����l�b�g���[�N�̓ǂݍ���
net = googlenet;
class_names = net.Layers(end).ClassNames;
cam = webcam;

%% �\���̏���
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
