using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace SistemaAdministracionSalonBelleza.AdministradorAplication
{
    public partial class Loading : Form
    {
        public Loading()
        {
            InitializeComponent();
        }
        private int Counter;

        private void Loading_Load(object sender, EventArgs e)
        {
            TimeCounter.Enabled = true;
            TimeCounter.Interval = 100;
            TimeCounter.Start();

            TimeCounter.Tick += new EventHandler(TimeCounter_Tick);
        }
        private void TimeCounter_Tick(object sender, EventArgs e)
        {
            Counter = Counter + 1;
            if (Counter == 100)
            {
                TimeCounter.Stop();
                this.Hide();
                Forms.MainMenu p = new Forms.MainMenu();
                p.Show();
            }
        }
    }
}