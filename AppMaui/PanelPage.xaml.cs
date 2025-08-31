namespace AppMaui;

public partial class PanelPage : ContentPage{
    public PanelPage(){
        InitializeComponent();
    }
    private void OnOpenMenuClicked(object sender, EventArgs e){
        Shell.Current.FlyoutIsPresented = true;
    }
}