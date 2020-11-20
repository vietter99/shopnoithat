using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShopNoiThat.Models;

namespace ShopNoiThat.Controllers
{
    public class GioHangController : Controller
    {
        // GET: GioHang
        dbQLNoithatDataContext data = new dbQLNoithatDataContext();
        public List<Giohang> getGioHang()
        {
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if(lstGiohang == null)
            {
                lstGiohang = new List<Giohang>();
                Session["Giohang"] = lstGiohang;
            }
            return lstGiohang;
        }
        public ActionResult themGioHang(int iMasp, string strURL)
        {
            List<Giohang> lstGiohang = getGioHang();
            Giohang sanpham = lstGiohang.Find(n => n.iMasp == iMasp);
            if(sanpham == null)
            {
                sanpham = new Giohang(iMasp);
                lstGiohang.Add(sanpham);
                return Redirect(strURL);
            }
            else
            {
                sanpham.iSoluong++;
                return Redirect(strURL);
            }
        }
        public ActionResult xoaGioHang(int iMasp)
        {
            List<Giohang> lstGiohang = getGioHang();
            Giohang sanpham = lstGiohang.SingleOrDefault(n => n.iMasp == iMasp);
            if(sanpham != null)
            {
                lstGiohang.RemoveAll(n => n.iMasp == iMasp);
                return RedirectToAction("gioHang");
            }
            if(lstGiohang.Count == 0)
            {
                return RedirectToAction("Index", "NoiThat");
            }
            return RedirectToAction("gioHang");
        }
        private int tongSoLuong()
        {
            int iTongSoLuong = 0;
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if(lstGiohang != null)
            {
                iTongSoLuong = lstGiohang.Sum(n => n.iSoluong);
            }
            return iTongSoLuong;
        }
        private double tongTien()
        {
            double iTongTien = 0;
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if (lstGiohang != null)
            {
                iTongTien = lstGiohang.Sum(n => n.dThanhtien);
            }
            return iTongTien;
        }
        [HttpGet]
        public ActionResult datHang()
        {
            if (Session["Giohang"] == null)
            {
                return RedirectToAction("Index", "NoiThat");
            }
            // Lấy giỏ hàng từ Session
            List<Giohang> lstGiohang = getGioHang();
            ViewBag.TongSoLuong = tongSoLuong();
            ViewBag.TongTien = tongTien();
            return View(lstGiohang);
        }
        public ActionResult datHang(FormCollection collection)
        {
            DONDATHANG ddh = new DONDATHANG();
            List<Giohang> gh = getGioHang();
            var hoten = collection["name"];
            var diachi = collection["address"];
            var sdt = collection["phone"];
            var ghichu = collection["comment"];
            if (String.IsNullOrEmpty(hoten))
            {
                ViewData["Loi1"] = "Họ tên khách hàng không được để trống";
            }
            else if (String.IsNullOrEmpty(diachi))
            {
                ViewData["Loi2"] = "Địa chỉ không được để trống";
            }
            else if (String.IsNullOrEmpty(sdt))
            {
                ViewData["Loi3"] = "Số điện thoại không được để trống";
            }
            else
            {
                ddh.HoTen = hoten;
                ddh.DiachiKH = diachi;
                ddh.DienthoaiKH = sdt;
                ddh.GhiChu = ghichu;
                ddh.Tinhtranggiaohang = false;
                ddh.Dathanhtoan = false;
                data.DONDATHANGs.InsertOnSubmit(ddh);
                data.SubmitChanges();
                foreach (var item in gh)
                {
                    CHITIETDONTHANG ctdh = new CHITIETDONTHANG();
                    ctdh.MaDonHang = ddh.MaDonHang;
                    ctdh.Masp = item.iMasp;
                    ctdh.Soluong = item.iSoluong;
                    ctdh.Dongia = (decimal)item.dDongia;
                    data.CHITIETDONTHANGs.InsertOnSubmit(ctdh);
                }
                data.SubmitChanges();
                Session["Giohang"] = null;
                return RedirectToAction("xacNhanDonHang", "GioHang");
            }
            return this.datHang();
        }
        public ActionResult xacNhanDonHang()
        {
            return View();
        }
        public ActionResult gioHang()
        {
            List<Giohang> lstGiohang = getGioHang();
            if(lstGiohang.Count == 0)
            {
                return RedirectToAction("Index", "NoiThat");
            }
            ViewBag.TongSoLuong = tongSoLuong();
            ViewBag.tongTien = tongTien();
            return View(lstGiohang);
        }
        public ActionResult gioHangPartial()
        {
            ViewBag.TongSoLuong = tongSoLuong();
            ViewBag.TongTien = tongTien();
            return PartialView();
        }
    }
}