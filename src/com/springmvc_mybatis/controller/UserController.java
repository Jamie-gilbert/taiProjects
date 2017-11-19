package com.springmvc_mybatis.controller;

import java.io.Writer;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.springmvc_mybatis.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc_mybatis.bean.User;
import com.springmvc_mybatis.mapper.UserMapper;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserMapper usermapper;

    @RequestMapping("/login")
    public String login(HttpServletRequest request, Model model) {
        String name = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("login");
        User user_login = usermapper.login(name, password);
        System.out.println(user_login);
        if (user_login == null) {
            System.out.println("Error login!");
            return "fail";
        } else {
            model.addAttribute("user", user_login);
            return "department";
        }
    }

    @RequestMapping("/register")
    public void register(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String yhxm = request.getParameter("yhxm");
        String kl = request.getParameter("kl");
        String sfzhm = request.getParameter("sfzhm");
        String xb = request.getParameter("xb");
        String lxdh = request.getParameter("lxdh");
        String jbjgid = request.getParameter("jbjgid");
        String jbr = request.getParameter("jbr");
//        String jbsj = request.getParameter("jbsj");
        String bz = request.getParameter("bz");
        String yhid = yhxm;
        String yhbh = yhxm;
        Date jbsj = new Date();
        try {
            usermapper.register(
                     yhbh + ""
                    , kl + ""
                    , yhxm + ""
                    , sfzhm + ""
                    , xb + ""
                    , lxdh + ""
                    , jbjgid + ""
                    , jbr + ""
                    , jbsj
                    , bz + "");
            JSONObject object = new JSONObject();
            object.put("statusText", 0);
            object.put("responseText", "");
            Writer writer = response.getWriter();
            writer.write(object.toString());
            writer.flush();
            writer.close();
        } catch (Exception e) {
            if (e instanceof ClassCastException) {

            } else {
                throw e;
            }
        }



    }

    @RequestMapping("/list")
    public String getAllUsers(Model model) {
        List<User> users = usermapper.getAllUsers();
        model.addAttribute("users", users);
        System.out.println(users);
        return "list";

    }
}
