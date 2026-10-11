clc; clear; close all;

%% Incijalizacija parametara modela

Tsimulacija=10;
Fs = 5e3; % Frekvencija odabiranja 
Ts = 1 / Fs; % Perioda odabiranja 

% Parametri mehanickog podsistema 4tog reda

% OVDE MENJAM PARAMETRE ZA PRVI ZADATAK!!
% 1.verzija model (I)
%m1=2; m2=3; b1=2; b2=2.5; k=1e7; b12=3; % model (I)
% 2.verzija model (II)
m1 = 2; m2 = 3; b1 = 100; %2; 
b2 = 150; %2.5; 
k = 1e7; b12 = 200; %3; 

x1_0 = 0; x2_0 = 0; xd1_0=0; xd2_0=0; % pocetne vrednosti promenljivih stanja

% Parametri elektricnog podsistema, odnosno, aktuatora koji je u ovom slucaju DC motor
R = 2.4; L = 3.15e-3; kem = 20.28; kme = 20.28;
%% Simulacija frekvencijskih odziva sistema

% Hrstuct = linmod(' IME SIMULINK PROGRAMA MODELA SISTEMA ');

Hstruct = linmod('RLV4_elektromehanicki_OU'); % racuna lin. model u prostoru stanja

% podaci o modelu su upisani u strkturu podataka Hstruct (a,b,c,d su matrice modela u prostoru stanja)

H_motion_system = ss(Hstruct.a, Hstruct.b, Hstruct.c, Hstruct.d); % def model u prostoru stanja

G = tf(H_motion_system); % def model u formi matrice funkcija prenosa, i imamo 2 fje prenosa G(1), G(2)
freq = linspace(0.1,0.5/Ts,1e4); % niz frekvencija u [Hz] od 0.1 do 10000, duzine 0.5/Ts clanova niza
W = 2 * pi * freq; % niz frekvencija u [rad/s] ... tj. niz kruznih ucestanosti
[resp_P, resp_W] = freqresp(H_motion_system,W); % racunanje frekv. odziva modela H u takcama niza W

% resp_W je kolona kruznih ucestanosti (dok je W niz kruznih ucestanosti)

f = resp_W / (2*pi); % kolona frekvencija [Hz], i isto je kao i freq

% resp_P je hodograf amplitudno fazno frekvencijske kke, u ovom slucaju
% imamo trodimenzionalni niz, iz koga treba da izdvojimo niz koji se odnosi
% na vrednosti AFF kke 1) ulaza F do izlaza x1, i 2) ulaza F do izlaza x2
% size(resp_P) = 2 1 10000

P_u_to_x1 = transpose(squeeze(resp_P(1,:)));
% izdvaja se kolona AFF od F do x1 (recimo, da je samo squeeze(resp_P(1,:)) - bila bi izdvojena vrsta

mag_P_u_to_x1 = abs(P_u_to_x1); % kolona amplitudno f-ke karakteristike

% niz fazno f-ke karakteristike (racuna se faza kompleksnog broja)
pha_P_u_to_x1 = unwrap(angle(P_u_to_x1));
P_u_to_x2 = transpose(squeeze(resp_P(2,:))); % izdvaja se kolona AFF od F do x2
mag_P_u_to_x2 = abs(P_u_to_x2); % AF kka
pha_P_u_to_x2 = unwrap(angle(P_u_to_x2)); % FF kka
%% CRTANJE BODEOVIH DIJAGRAMA: OD napona u do pomeranja x1 i od napona u do pomeranja x2

% pozicioniranje slike
figure_position=[0.3 1.5 40 18]; % koordinate donjeg levog i gornjeg desnog ugla
fig_num = 1;
figure(fig_num)
set(gcf, 'units', 'centimeters', 'pos', figure_position)
subplot(2,1,1) % crtamo u 1vom polju matrice 2x1 na slici *gornja polovina
semilogx(f,20*log10(mag_P_u_to_x1),'LineWidth',2,'Color','b','LineStyle','-');
% log10 podela x ose, amplituda je u dB

hold % na istom dijagramu crtamo sledeci
semilogx(f,20*log10(mag_P_u_to_x2),'LineWidth',2,'Color','r','LineStyle','-'); % crtamo AF od F do x2
set(gca,'FontSize',20, 'FontName','Times New Roman','DefaultTextColor','black','xscale','log')
legend('{\itx}_1 фреквенцијски одзив на {\itU}','{\itx}_2 фреквенцијски одзив на {\itU}')
set(gca,'XTickLabel',{})
ylabel('Амплитуда [dB]','FontName','Times New Roman','FontSize',16) % oznaka y ose
title('Бодеови дијаграми електро-механичког објекта управљања') % naslov dijagrama
axis('tight')
grid on % mreza na dijagramima
subplot(2,1,2) % u drugoj celiji slike crtamo FF kku
semilogx(f,rad2deg(pha_P_u_to_x1),'LineWidth',2,'Color','b','LineStyle','-');
% radijani se pretvaraju u stepene

hold
semilogx(f,rad2deg(pha_P_u_to_x2),'LineWidth',2,'Color','r','LineStyle','-');
set(gca,'FontSize',20, 'FontName','Times New Roman','DefaultTextColor','black','xscale','log')
ylabel('Фаза [^o]','FontName','Times New Roman','FontSize',16)
xlabel('Фреквенција [Hz]','FontName','Times New Roman','FontSize',16)
axis('tight')
grid on
set(fig_num,'Color','white')