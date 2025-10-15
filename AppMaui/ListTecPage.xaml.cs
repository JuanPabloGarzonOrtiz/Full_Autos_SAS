using APIDatabase;
using System.Text.Json;
namespace AppMaui;

public partial class ListTecPage : ContentPage
{
    public ListTecPage(){
        InitializeComponent();
        String url = "https://www.google.com/maps/@4.7110,-74.0721,12z";
        MyWebView.Source = url;

        //Consulta de Trabajadores
        var json = DbConection.Query("SELECT nombre, cargo, foto FROM Empleados;", "list_Tec");
        json.ContinueWith(async data => {
            var query = JsonSerializer.Deserialize<List<Dictionary<string, string>>>( await json);
            foreach (var item in query){
                MainThread.BeginInvokeOnMainThread(() =>{
                    // Impresion de Trabajadores
                    var horizontalLayout = new HorizontalStackLayout { Spacing = 20, Padding = new Thickness(10, 10), HorizontalOptions = LayoutOptions.Start };

                    //Definicion de Imagen de Tecnico
                    horizontalLayout.Children.Add(
                        new ImageButton{
                            Source = "foto_tecnico.jpg",
                            BackgroundColor = Colors.Transparent,
                            WidthRequest = 85,
                            HeightRequest = 85
                        }
                    );
                    var verticalLayout = new VerticalStackLayout { VerticalOptions = LayoutOptions.Center };
                    //Definicion de Nombre de Tecnico
                    verticalLayout.Children.Add(
                        new Label { Text = item["Nombre"], TextColor = Color.FromArgb("#A5531C"), FontSize = 30 }
                    );
                    //Definicion de Puesto de Tecnico
                    verticalLayout.Children.Add(
                        new Label { Text = item["Cargo"], TextColor = Colors.White, FontSize = 20 }
                    );
                    horizontalLayout.Children.Add(verticalLayout);
                    section_Tecs.Children.Add(horizontalLayout);
                });
            }
        });

    }
    private void OnOpenMenuClicked(object sender, EventArgs e){
        Shell.Current.FlyoutIsPresented = true;
    }

}