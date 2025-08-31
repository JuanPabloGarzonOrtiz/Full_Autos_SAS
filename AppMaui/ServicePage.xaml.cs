namespace AppMaui;

public partial class ServicePage : ContentPage
{
    public ServicePage(){
        InitializeComponent();
    }
    private void OnOpenMenuClicked(object sender, EventArgs e){
        Shell.Current.FlyoutIsPresented = true;
    }
    private async void OnOpenListTecnicosClicked(object sender, EventArgs e){
        await Shell.Current.GoToAsync("//ListTecPage");
    }
}
