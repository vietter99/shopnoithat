using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShopNoiThat.Models
{
    public class Giohang
    {
        dbQLNoithatDataContext data = new dbQLNoithatDataContext();
        public int iMasp { get; set; }
        public string sTensp { get; set; }
        public string sAnhbia { get; set; }
        public Double dDongia { get; set; }
        public int iSoluong { get; set; }
        public Double dThanhtien
        {
            get { return iSoluong * dDongia; }
        }
        public Giohang(int Masp)
        {
            iMasp = Masp;
            SANPHAM sanpham = data.SANPHAMs.Single(n => n.Masp == iMasp);
            sTensp = sanpham.Tensp;
            sAnhbia = sanpham.Anhbia;
            dDongia = double.Parse(sanpham.Giaban.ToString());
            iSoluong = 1;
        }

    }
}