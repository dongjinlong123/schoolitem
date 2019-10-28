package com.len.core.shiro;

import com.len.base.CurrentRole;
import com.len.base.CurrentUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import java.util.List;

/**
 * 登录用户信息
 */
public class Principal {

    /**
     * 获取用户主题
     *
     * @return
     */
    public static Subject getSubject() {
        return SecurityUtils.getSubject();
    }

    /**
     * 获取当前用户对象
     * @return
     */
    public static CurrentUser getPrincipal() {
        return (CurrentUser) getSubject().getPrincipal();
    }

    /**
     * 当前session
     * @return
     */
    public static Session getSession() {
        return getSubject().getSession();
    }


    /**
     * 获取session中保存的用户信息
     * @return
     */
    public static CurrentUser getCurrentUse() {
        return (CurrentUser) getSession().getAttribute("currentPrincipal");
    }

    /**
     * 判断当前用户是否具有管理员权限
     * @return
     */
    public static boolean isAdmin(){
        CurrentUser currentUser  = (CurrentUser) Principal.getSession().getAttribute("currentPrincipal");
        List<CurrentRole> roleList = currentUser.getCurrentRoleList();
        if(roleList != null && roleList.size() > 0){
            for(CurrentRole c : roleList){
                if("admin".equals(c.getRoleName())){
                    return true;
                }
            }
        }
        return false;
    }

}
