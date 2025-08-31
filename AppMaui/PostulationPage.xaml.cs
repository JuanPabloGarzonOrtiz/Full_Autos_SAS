namespace AppMaui;

public partial class PostulationPage : ContentPage{
    public PostulationPage(){
        InitializeComponent();
    }
    private void OnOpenMenuClicked(object sender, EventArgs e){
        Shell.Current.FlyoutIsPresented = true;
    }
}