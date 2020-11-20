using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShopNoiThat.Models;

using PagedList;
using PagedList.Mvc;
namespace ShopNoiThat.Controllers
{
    public class AdminController : Controller
    {
        dbQLNoithatDataContext db = new dbQLNoithatDataContext();
        // GET: Admin
        public ActionResult Index(int ?page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.SANPHAMs.ToList().OrderBy(n => n.Masp).ToPagedList(pageNumber, pageSize));
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(FormCollection collection)
        {
            // Gán các giá trị người dùng nhập liệu cho các biến 
            var tendn = collection["useradmin"];
            var matkhau = collection["passadmin"];
            if (String.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Phải nhập tên đăng nhập";
            }
            else if (String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Phải nhập mật khẩu";
            }
            else
            {
                //Gán giá trị cho đối tượng được tạo mới (ad)        

                ADMIN ad = db.ADMINs.SingleOrDefault(n => n.UserAdmin == tendn && n.PassAdmin == matkhau);
                if (ad != null)
                {
                    // ViewBag.Thongbao = "Chúc mừng đăng nhập thành công";
                    Session["Taikhoanadmin"] = ad;
                    return RedirectToAction("Index", "Admin");
                }
                else
                    ViewBag.Thongbao = "Tên đăng nhập hoặc mật khẩu không đúng";
            }
            return View();
        }

        // Thêm sản phẩm
        [HttpGet]
        public ActionResult themSP()
        {
            ViewBag.MaLoaiSP = new SelectList(db.LOAISANPHAMs.ToList().OrderBy(n => n.TenLoaiSP), "MaLoaiSP", "TenLoaiSP");
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult themSP(SANPHAM sp, HttpPostedFileBase fileupload)
        {
            ViewBag.MaLoaiSP = new SelectList(db.LOAISANPHAMs.ToList().OrderBy(n => n.TenLoaiSP), "MaLoaiSP", "TenLoaiSP");
            if (fileupload == null)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh bìa";
                return View();
            }
            else
            {
                if (ModelState.IsValid)
                {
                    var fileName = Path.GetFileName(fileupload.FileName);
                    var path = Path.Combine(Server.MapPath("~/Images/sanpham"), fileName);
                    if (System.IO.File.Exists(path))
                    {
                        ViewBag.Thongbao = "Hình ảnh đã tồn tại";
                    }
                    else
                    {
                        fileupload.SaveAs(path);
                    }
                    sp.Anhbia = fileName;
                    db.SANPHAMs.InsertOnSubmit(sp);
                    db.SubmitChanges();
                }
                return RedirectToAction("Index");
            }
        }

        // Xem chi tiết sản phẩm
        public ActionResult xemSP( int id)
        {
            SANPHAM sanpham = db.SANPHAMs.SingleOrDefault(n => n.Masp == id);
            ViewBag.Masp = sanpham.Masp;
            if (sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sanpham);
        }

        // Xóa sản phẩm
        public ActionResult xoaSP( int id)
        {
            SANPHAM sanpham = db.SANPHAMs.SingleOrDefault(n => n.Masp == id);
            if (sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sanpham);
        }
        [HttpPost,ActionName("xoaSP")]
        public ActionResult xacNhanXoa (int id)
        {
            SANPHAM sanpham = db.SANPHAMs.SingleOrDefault(n => n.Masp == id);
            ViewBag.Masp = sanpham.Masp;
            if (sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.SANPHAMs.DeleteOnSubmit(sanpham);
            db.SubmitChanges();
            return RedirectToAction("Index");
        }

        // Sửa sản phẩm
        [HttpGet]
        public ActionResult suaSP(int id)
        {
            SANPHAM sanpham = db.SANPHAMs.SingleOrDefault(n => n.Masp == id);
            ViewBag.Masp = sanpham.Masp;
            if (sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            ViewBag.MaLoaiSP = new SelectList(db.LOAISANPHAMs.ToList().OrderBy(n => n.TenLoaiSP), "MaLoaiSP", "TenLoaiSP", sanpham.MaLoaiSP);
            return View(sanpham);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult suaSP(SANPHAM sp, HttpPostedFileBase fileupload)
        {
            ViewBag.MaLoaiSP = new SelectList(db.LOAISANPHAMs.ToList().OrderBy(n => n.TenLoaiSP), "MaLoaiSP", "TenLoaiSP");
            if (fileupload == null)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh bìa";
                return View();
            }
            else
            {
                if (ModelState.IsValid)
                {
                    var fileName = Path.GetFileName(fileupload.FileName);
                    var path = Path.Combine(Server.MapPath("~/Images/sanpham"), fileName);
                    if (System.IO.File.Exists(path))
                    {
                        ViewBag.Thongbao = "Hình ảnh đã tồn tại";
                    }
                    else
                    {
                        fileupload.SaveAs(path);
                    }
                    sp.Anhbia = fileName;
                    UpdateModel(sp);
                    SANPHAM sanpham = new SANPHAM();
                    sanpham = db.SANPHAMs.SingleOrDefault(n => n.Masp == sp.Masp);
                    db.SANPHAMs.DeleteOnSubmit(sanpham);
                    db.SANPHAMs.InsertOnSubmit(sp); 
                    db.SubmitChanges();
                }
                return RedirectToAction("Index");
            }
        }

        // Quản lý loại sản phẩm
        public ActionResult dsLoaiSP()
        {
            return View(db.LOAISANPHAMs.ToList());
        }

        // Xem sản phẩm loại sản phẩm
        public ActionResult xemSPTheoLoaiSP(int id, int ? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            var sanpham = from s in db.SANPHAMs where s.MaLoaiSP == id select s;
            return View(sanpham.ToPagedList(pageNumber, pageSize));
        }

        // Thêm loại sản phẩm
        [HttpGet]
        public ActionResult themLoaiSP()
        {
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult themLoaiSP(LOAISANPHAM loaisp)
        {
            ViewBag.MaLoaiSP = new SelectList(db.LOAISANPHAMs.ToList().OrderBy(n => n.TenLoaiSP), "MaLoaiSP", "TenLoaiSP");
            if (ModelState.IsValid)
            {
                db.LOAISANPHAMs.InsertOnSubmit(loaisp);
                db.SubmitChanges();
            }
            return RedirectToAction("Index");
        }

        // Chỉnh sửa loại sản phẩm
        [HttpGet]
        public ActionResult suaLoaiSP(int id)
        {
            LOAISANPHAM loaisp = db.LOAISANPHAMs.SingleOrDefault(n => n.MaLoaiSP == id);
            if (loaisp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(loaisp);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult suaLoaiSP(LOAISANPHAM loaisp)
        {
            if (ModelState.IsValid)
            {
                UpdateModel(loaisp);
                LOAISANPHAM loaisanpham = new LOAISANPHAM();
                loaisanpham = db.LOAISANPHAMs.SingleOrDefault(n => n.MaLoaiSP == loaisp.MaLoaiSP);
                db.LOAISANPHAMs.DeleteOnSubmit(loaisanpham);
                db.LOAISANPHAMs.InsertOnSubmit(loaisp);
                db.SubmitChanges();
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        // Xóa loại sản phẩm
        public ActionResult xoaLoaiSP(int id)
        {
            LOAISANPHAM loaisp = db.LOAISANPHAMs.SingleOrDefault(n => n.MaLoaiSP == id);
            if (loaisp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(loaisp);
        }
        [HttpPost, ActionName("xoaLoaiSP")]
        public ActionResult xacNhanXoaLoaiSP(int id)
        {
            LOAISANPHAM loaisp = db.LOAISANPHAMs.SingleOrDefault(n => n.MaLoaiSP == id);
            if (loaisp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.LOAISANPHAMs.DeleteOnSubmit(loaisp);
            db.SubmitChanges();
            return RedirectToAction("Index");
        }

        // Quản lý đơn hàng
        public ActionResult dsDonHang(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.DONDATHANGs.ToList().ToPagedList(pageNumber, pageSize));
        }

        // Xem chi tiết đơn đặt hàng
        public ActionResult xemDonHang(int id)
        {
            DONDATHANG donhang = db.DONDATHANGs.SingleOrDefault(n => n.MaDonHang == id);
            if (donhang == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(donhang);
        }

        // Chỉnh sửa đơn đặt hàng
        [HttpGet]
        public ActionResult suaDonHang(int id)
        {
            DONDATHANG donhang = db.DONDATHANGs.SingleOrDefault(n => n.MaDonHang == id);
            if (donhang == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(donhang);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult suaDonHang(DONDATHANG donhang)
        {
            if (ModelState.IsValid)
            {
                UpdateModel(donhang);
                DONDATHANG dondathang = new DONDATHANG();
                dondathang = db.DONDATHANGs.SingleOrDefault(n => n.MaDonHang == donhang.MaDonHang);
                db.DONDATHANGs.DeleteOnSubmit(dondathang);
                db.DONDATHANGs.InsertOnSubmit(donhang);
                db.SubmitChanges();
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        // Xóa đơn đặt hàng
        public ActionResult xoaDonHang(int id)
        {
            DONDATHANG donhang = db.DONDATHANGs.SingleOrDefault(n => n.MaDonHang == id);
            if (donhang == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(donhang);
        }
        [HttpPost, ActionName("xoaDonHang")]
        public ActionResult xacNhanXoaDonHang(int id)
        {
            DONDATHANG donhang = db.DONDATHANGs.SingleOrDefault(n => n.MaDonHang == id);
            if (donhang == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.DONDATHANGs.DeleteOnSubmit(donhang);
            db.SubmitChanges();
            return RedirectToAction("Index");
        }

    }
}