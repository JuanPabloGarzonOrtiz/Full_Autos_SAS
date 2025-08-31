using System;
namespace AppMaui
{
    public partial class MainPage : ContentPage
    {
        public MainPage(){
            InitializeComponent();
            String url = "https://www.google.com/maps/@4.7110,-74.0721,12z";
            MyWebView.Source = url;
        }
        //Llamada al Menu de Navegación
        private void OnOpenMenuClicked(object sender, EventArgs e){
            Shell.Current.FlyoutIsPresented = true;
        }
        private async void OnOpenServiceClicked(object sender, EventArgs e){
            await Shell.Current.GoToAsync("//ServicePage");
        }
        private async void OnOpenFormClicked(object sender, EventArgs e){
            await Shell.Current.GoToAsync("//PostulationPage");
        }
    }
}