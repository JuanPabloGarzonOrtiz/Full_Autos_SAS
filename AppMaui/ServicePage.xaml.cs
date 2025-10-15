using APIDatabase;
using System.Collections.Generic;
using System.Text.Json;
namespace AppMaui;

[QueryProperty(nameof(Name), "name")]  //Vinculacion de parm name a Propiedad Name
public partial class ServicePage : ContentPage{    
    public ServicePage(){
        InitializeComponent();
    }

    public string Name{
        set{
            Name_Service.Text = value; //Asingancion de valor receptado
            var json = DbConection.Query($"SELECT * FROM Servicios WHERE nombre = '{value}';", "data_Service");
            json.ContinueWith(async data =>{
                var query = JsonSerializer.Deserialize<List<Dictionary<string, string>>>( await json);
                List<string> materiales = JsonSerializer.Deserialize<List<string>>(query[0]["Materiales"].ToString());
                MainThread.BeginInvokeOnMainThread(() =>{
                    Precio_Service.Text = $"${query[0]["Precio"]}";
                    Time_Service.Text = $"{query[0]["Tiempo"]} Min";
                    Materiales_Service.Text = string.Join("\n", materiales);
                });
            });
        }
    }

    private void OnOpenMenuClicked(object sender, EventArgs e){
        Shell.Current.FlyoutIsPresented = true;
    }
    private async void OnOpenListTecnicosClicked(object sender, EventArgs e){
        await Shell.Current.GoToAsync("//ListTecPage");
    }
}
