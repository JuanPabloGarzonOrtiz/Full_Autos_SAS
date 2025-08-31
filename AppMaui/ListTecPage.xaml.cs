namespace AppMaui;

public partial class ListTecPage : ContentPage
{
    public ListTecPage(){
        InitializeComponent();
        String url = "https://www.google.com/maps/@4.7110,-74.0721,12z";
        MyWebView.Source = url;
    }
    private void OnOpenMenuClicked(object sender, EventArgs e){
        Shell.Current.FlyoutIsPresented = true;
    }

}