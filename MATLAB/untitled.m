function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 01-Dec-2016 20:19:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
changeBudgetText(hObject,handles,NaN);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stats;
global objs;
off_def=get(handles.slider1,'Value');
wid_cen=get(handles.slider2,'Value');
budget=get(handles.text9,'String');
budget = budget(2:end);
budget = str2double(budget);
if strcmp(get(hObject,'String'),'Optimize')
    [stats,objs_]=getOptimStats(off_def,wid_cen,budget,handles);
    objs=[objs objs_];
    set(hObject,'String','Select Players');
elseif strcmp(get(hObject,'String'),'Select Players')
    [objs_] = selectPlayers(stats,handles);
    objs=[objs objs_];
    set(hObject,'String','Reset');
elseif strcmp(get(hObject,'String'),'Reset')
    for obj=objs,
        obj.delete();
    end
    set(handles.slider1,'Value',0);
    set(handles.slider2,'Value',0);
    set(handles.slider3,'Value',0);
    changeBudgetText(hObject,handles,0);
    set(hObject,'String','Optimize');
end

function [stats,objs] = getOptimStats(off_def,wid_cen,budget,handles)
objs=[];
nplayers=7;
nstats=7;
stats=mainn2(budget,off_def,wid_cen);
for p=1:nplayers,
    switch p
        case 1
            pnl=[handles.uipanel1,handles.uipanel3];
        case 2
            pnl=[handles.uipanel2];
        case 3
            pnl=[handles.uipanel4,handles.uipanel6];
        case 4
            pnl=[handles.uipanel5];
        case 5
            pnl=[handles.uipanel7,handles.uipanel10];
        case 6
            pnl=[handles.uipanel8,handles.uipanel9];
        case 7
            pnl=[handles.uipanel11];
    end
    for s=1:nstats,
        stat=stats(p,s);
        switch s
            case 1
                if (p~=7)
                    stattext=sprintf('Pace: %d',round(stats(p,s)));
                else
                    stattext=sprintf('Positioning: %d',round(stats(p,s)));
                end
            case 2
                if (p~=7)
                    stattext=sprintf('Shooting: %d',round(stats(p,s)));
                else
                    stattext=sprintf('Diving: %d',round(stats(p,s)));
                end
            case 3
                if (p~=7)
                    stattext=sprintf('Passing: %d',round(stats(p,s)));
                else
                    stattext=sprintf('Handling: %d',round(stats(p,s)));
                end
            case 4
                if (p~=7)
                    stattext=sprintf('Dribbing: %d',round(stats(p,s)));
                else
                    stattext=sprintf('Positioning: %d',round(stats(p,s)));
                end
            case 5
                if (p~=7)
                    stattext=sprintf('Defense: %d',round(stats(p,s)));
                else
                    stattext=sprintf('Kicking: %d',round(stats(p,s)));
                end
            case 6
                stattext=sprintf('Physical: %d',round(stats(p,s)));
            case 7
                stattext=sprintf('Overall: %d',round(stats(p,s)));
        end
        for ppanel=pnl,
            if (p==7)
                color=[1 0.8 .94];
            else
                color=[0.992 0.918 0.796];
            end
            if (s==1)
                t=uicontrol(ppanel,'Style','text','String',...
                    'Optimum Stats','FontWeight','Bold',...
                    'HorizontalAlignment','left','Position',...
                    [5 85 90 12],'BackgroundColor',color);
                objs=[objs t];
                t=uicontrol(ppanel,'Style','text','String',stattext,...
                    'HorizontalAlignment','left','Position',...
                    [5 85-12*s 90 12],'BackgroundColor',color);
                objs=[objs t];
            elseif (s==7)
                t=uicontrol(ppanel,'Style','text','String',stattext,...
                    'FontWeight','Bold','HorizontalAlignment','left',...
                    'Position',[5 85-12*s 90 12],'BackgroundColor',color);
                objs=[objs t];
            else
                t=uicontrol(ppanel,'Style','text','String',stattext,...
                    'HorizontalAlignment','left','Position',...
                    [5 85-12*s 90 12],'BackgroundColor',color);
                objs=[objs t];
            end
        end
    end
    drawnow();
end

function [objs] = selectPlayers(stats,handles)
objs=[];
nplayers=7;
nstats=7;
for p=1:nplayers,
    switch p
        case 1
            pnl=[handles.uipanel1,handles.uipanel3];
            filename='Wingers.xlsx';
        case 2
            pnl=[handles.uipanel2];
            filename='Strikers.xlsx';
        case 3
            pnl=[handles.uipanel4,handles.uipanel6];
            filename='SideM.xlsx';
        case 4
            pnl=[handles.uipanel5];
            filename='CenterM.xlsx';
        case 5
            pnl=[handles.uipanel7,handles.uipanel10];
            filename='SideB.xlsx';
        case 6
            pnl=[handles.uipanel8,handles.uipanel9];
            filename='CenterB.xlsx';
        case 7
            pnl=[handles.uipanel11];
            filename='GK.xlsx';
    end
    [recPlayer, playerStats] = selectPlayer( stats(p,:),filename );
    for s=1:nstats,
        stat=playerStats(:,s);
        for ppanel=1:length(pnl),
            switch s
                case 1
                    if (p~=7)
                        stattext=sprintf('Pace: %d',round(stat(ppanel,:)));
                    else
                        stattext=sprintf('Positioning: %d',round(stat(ppanel,:)));
                    end
                case 2
                    if (p~=7)
                        stattext=sprintf('Shooting: %d',round(stat(ppanel,:)));
                    else
                        stattext=sprintf('Diving: %d',round(stat(ppanel,:)));
                    end
                case 3
                    if (p~=7)
                        stattext=sprintf('Passing: %d',round(stat(ppanel,:)));
                    else
                        stattext=sprintf('Handling: %d',round(stat(ppanel,:)));
                    end
                case 4
                    if (p~=7)
                        stattext=sprintf('Dribbing: %d',round(stat(ppanel,:)));
                    else
                        stattext=sprintf('Positioning: %d',round(stat(ppanel,:)));
                    end
                case 5
                    if (p~=7)
                        stattext=sprintf('Defense: %d',round(stat(ppanel,:)));
                    else
                        stattext=sprintf('Kicking: %d',round(stat(ppanel,:)));
                    end
                case 6
                    stattext=sprintf('Physical: %d',round(stat(ppanel,:)));
                case 7
                    stattext=sprintf('Overall: %d',round(stat(ppanel,:)));
            end
            if (p==7)
                color=[1 0.8 .94];
            else
                color=[0.992 0.918 0.796];
            end
            if (s==1)
                t1=uicontrol(pnl(ppanel),'Style','text','String',...
                    'Recommended Player:','FontWeight','Bold',...
                    'HorizontalAlignment','left','Position',...
                    [100 97 125 12],'BackgroundColor',color);
                t2=uicontrol(pnl(ppanel),'Style','text','String',...
                    recPlayer{ppanel},'FontWeight','Bold',...
                    'HorizontalAlignment','left','Position',...
                    [100 85 125 12],'BackgroundColor',color);
                objs=[objs t1 t2];
                t=uicontrol(pnl(ppanel),'Style','text','String',stattext,...
                    'HorizontalAlignment','left','Position',...
                    [100 85-12*s 90 12],'BackgroundColor',color);
                objs=[objs t];
            elseif (s==7)
                t=uicontrol(pnl(ppanel),'Style','text','String',stattext,...
                    'FontWeight','Bold','HorizontalAlignment','left',...
                    'Position',[100 85-12*s 90 12],'BackgroundColor',...
                    color);
            objs=[objs t];
            else
                t=uicontrol(pnl(ppanel),'Style','text','String',stattext,...
                    'HorizontalAlignment','left','Position',...
                    [100 85-12*s 90 12],'BackgroundColor',color);
                objs=[objs t];
            end
        end
    end
    drawnow();
end

function [] = changeBudgetText(hObject,handles,BudgetSliderVal)
BudgetMin=900e3;
BudgetMax=1e10;
s=10;
if (isnan(BudgetSliderVal))
    BudgetSliderVal=(exp(s*get(hObject,'Value'))-1)/(exp(s)-1);
end
BudgetSetVal=round(BudgetMin+(BudgetMax-BudgetMin)*BudgetSliderVal,3,...
    'Significant');
set(handles.text9,'String',sprintf('$%.0f',BudgetSetVal));

function [ bestname, beststat ] = selectPlayer( stats,filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [~,~,PM] = xlsread(filename);
    [m,~]=size(PM);
    bestrms=Inf;
    bestrms2=Inf;
    beststat=zeros(2,7);
    bestname={};
    for i=2:m,
        pname=PM{i,9};
        pstat=cell2mat(PM(i,1:7));
        prms=rms(stats-pstat);
        if (prms<bestrms)
            bestrms=prms;
            beststat(1,:)=pstat;
            bestname{1}=pname;
        elseif (prms<bestrms2)
            bestrms2=prms;
            beststat(2,:)=pstat;
            bestname{2}=pname;
        end
    end
