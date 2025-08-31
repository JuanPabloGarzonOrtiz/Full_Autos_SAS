namespace AppMaui;

public partial class LoginPage : ContentPage{
    public LoginPage(){
        InitializeComponent();
    }
    private void OnOpenMenuClicked(object sender, EventArgs e){
        Shell.Current.FlyoutIsPresented = true;
    }
    private async void OnOpenPanelClicked(object sender, EventArgs e){
        await Shell.Current.GoToAsync("//PanelPage");
    }
}