using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShopNoiThat.Models;


using PagedList;
using PagedList.Mvc;
namespace ShopNoiThat.Controllers
{
    public class NoiThatController : Controller
    {
        dbQLNoithatDataContext data = new dbQLNoithatDataContext();
        private List<SANPHAM> getSpMoi(int count)
        {
            return data.SANPHAMs.OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
        }
        private List<SANPHAM> getSpTheoTax(int count, int tax)
        {
            return data.SANPHAMs.Where(a => a.MaLoaiSP == tax).OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
        }
        // GET: NoiThat
        public ActionResult Index()
        {
            var spNew = getSpMoi(5);
            return View(spNew);
        }
        public ActionResult loaiSP()
        {
            var loaisp = from cd in data.LOAISANPHAMs select cd;
            return PartialView(loaisp);
        }
        public ActionResult sidebarLoaiSP()
        {
            var loaisp = from cd in data.LOAISANPHAMs select cd;
            return PartialView(loaisp);
        }
        public ActionResult SPTheoloai(int id)
        {
            var sanpham = from s in data.SANPHAMs where s.MaLoaiSP == id select s;
            return View(sanpham);
        }
        public ActionResult Details(int id)
        {
            var sanpham = from s in data.SANPHAMs
                          where s.Masp == id
                          select s;
            return View(sanpham.Single());
        }
    }
}