using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Logic.LogicaNegocio;
using Logic;

namespace SistemaAdministracionSalonBelleza.AdministradorAplication
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }
        private Login_Logic loginLogica = new Login_Logic();
        
      
        private void linkpass_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            LoginAdmin admin = new AdministradorAplication.LoginAdmin();
            this.Hide();
            admin.Show();
        }

        private void btnlogin_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrWhiteSpace(txtuser.Text))
            {
                lblErrorUsuario.Visible = true;
                txtuser.Focus();

                return;
            }
            else if (String.IsNullOrWhiteSpace(txtpass.Text))
            {
                lblErrorPass.Visible = true;
                txtpass.Focus();

                return;
            }
            else
            {
                LoginVerificacion(txtuser.Text.Trim(), txtpass.Text.Trim());
            }
             
        }


        private void LoginVerificacion(string usu,string clave)
        { 
            var p = loginLogica.RollID_Metodo(usu,clave);
            if (p == null)
            {
                Alertas.AlertaAdvertencias AD = new Alertas.AlertaAdvertencias("No se Encontro Ningún Usuario Registrado");
                AD.ShowDialog();
                txtuser.Focus();
            } else
            {
             if (p.Usuario != usu)
            {
                    lblErrorUsuario.Visible = true;
                    txtuser.Focus();
                   
            }
                else if(clave!=Utility.Decrypt_Query(p.Clave))
                {
                    lblErrorPass.Visible = true;
                    txtpass.Focus();
                }
                else if(clave == Utility.Decrypt_Query(p.Clave) && p.Usuario == usu)
                {
                    var verificarRoll = loginLogica.RollID_Metodo(p.RolID);
                    Seccion.Instance.Pocision = verificarRoll.Nombre;
                    Seccion.Instance.Usuario = p.Usuario;

                    Formularios.FrmMenuPrincipal mp = new Formularios.FrmMenuPrincipal();
                    mp.Show();
                }
            }
    }

        private void txtuser_Click(object sender, EventArgs e)
        {
             
        }

        private void txtuser_KeyPress(object sender, KeyPressEventArgs e)
        {
            lblErrorUsuario.Visible = false;
        }

        private void iconcerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void txtpass_KeyPress(object sender, KeyPressEventArgs e)
        {
            lblErrorPass.Visible = false;
        }
    }
}
