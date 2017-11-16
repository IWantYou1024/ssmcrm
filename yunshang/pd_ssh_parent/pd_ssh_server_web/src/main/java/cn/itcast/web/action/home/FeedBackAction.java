package cn.itcast.web.action.home;

import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;

import cn.itcast.domain.home.FeedBack;
import cn.itcast.domain.sysadmin.Dept;
import cn.itcast.domain.sysadmin.User;
import cn.itcast.service.FeedBackService;
import cn.itcast.service.UserService;
import cn.itcast.utils.MailUtil;
import cn.itcast.utils.SysConstant;
import cn.itcast.web.action.BaseAction;

@Namespace(value="/home")
public class FeedBackAction extends BaseAction<FeedBack> {
	
	public FeedBack setModel() {
		return new FeedBack();
	}
	
	@Autowired
	private FeedBackService feedBackService;
	//列表显示
	@Action(value="feedBackAction_touser",results=@Result(name="touser",location="/WEB-INF/pages/home/feedback/jFeedBackList.jsp"))
	public String touser() throws Exception {
		//条件 查询公开的
		Specification<FeedBack> spec = new Specification<FeedBack>(){
			@Override
			public Predicate toPredicate(Root<FeedBack> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.equal(root.get("isShare").as(String.class), 1);
			}};
		//分页	
		Page<FeedBack> page2 = feedBackService.findPage(spec, new PageRequest(page.getPageNo()-1, page.getPageSize()));
		super.parsePage(page, page2);
		page.setUrl("feedBackAction_touser");
		super.push(page);
		return "touser";
	}
	//查看具体信息
	@Action(value="feedBackAction_toView",results=@Result(name="toView",location="/WEB-INF/pages/home/feedback/jFeedBackView.jsp"))
	public String toView() throws Exception {
		FeedBack feedBack = feedBackService.get(model.getId());
		super.push(feedBack);
		return "toView";
	}
	
	//察看我发出的反馈
	@Action(value="feedBackAction_myList",results=@Result(name="myList",location="/WEB-INF/pages/home/feedback/jFeedBackMyList.jsp"))
	public String myList() throws Exception {
		//获得session中的User对象
		final User user = (User) session.get(SysConstant.CURRENT_USER_INFO);
		//条件查询 当前用户下的 插入者或者回复者
		Specification<FeedBack> spec = new Specification<FeedBack>(){
			public Predicate toPredicate(Root<FeedBack> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate p1 = cb.equal(root.get("inputBy").as(String.class),user.getUserinfo().getName() );

				return p1;
			}};
			//分页
			Page<FeedBack> page2 = feedBackService.findPage(spec, new PageRequest(page.getPageNo()-1, page.getPageSize()));
			super.parsePage(page, page2);
			page.setUrl("feedBackAction_myList");
			super.push(page);
		
			
			
		return "myList";
	}
	//察看我解决的反馈
	@Action(value="feedBackAction_myHandleHList",results=@Result(name="myHandleHList",location="/WEB-INF/pages/home/feedback/jFeedBackMyHandleList.jsp"))
	public String myHandleHList() throws Exception {
		//获得session中的User对象
		final User user = (User) session.get(SysConstant.CURRENT_USER_INFO);
		//条件查询 当前用户下的 插入者或者回复者
		
			
			Specification<FeedBack> spec2 = new Specification<FeedBack>(){
				public Predicate toPredicate(Root<FeedBack> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
					Predicate p2 = cb.equal(root.get("answerBy").as(String.class),user.getUserinfo().getName() );
					
					return p2;
				}};
				//分页
				Page<FeedBack> page3 = feedBackService.findPage(spec2, new PageRequest(page.getPageNo()-1, page.getPageSize()));
				super.parsePage(page, page3);
				page.setUrl("feedBackAction_myList");
				super.push(page);
				return "myHandleHList";
	}
	
	@Autowired
	private UserService userService;
	
	//跳转新增页面
	@Action(value="feedBackAction_toCreate",results=@Result(name="toCreate",location="/WEB-INF/pages/home/feedback/jFeedBackCreate.jsp"))
	public String toCreate() throws Exception {
		final User user = (User) session.get(SysConstant.CURRENT_USER_INFO);
		
		Specification<User> spec = new Specification<User>(){
			public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Join<User, Dept> join = root.join("dept");
				return cb.equal(join.get("id").as(String.class),user.getDept().getId() );
			}};
			
		List<User> userList = userService.find(spec);
		
		super.put("userList", userList);
		
		return "toCreate";
	}
	
	//新增页面
	@Action(value="feedBackAction_insert",results=@Result(name="success",type="redirect",location="feedBackAction_myList"))
	public String insert() throws Exception {
		final User user = (User) session.get(SysConstant.CURRENT_USER_INFO);
		model.setState("0");
		model.setInputBy(user.getUserinfo().getName());
		model.setCreateBy(user.getUserinfo().getName());
		model.setCreateDept(user.getDept().getDeptName());
		model.setAnswerTime(new Date());
		model.setInputTime(new Date());
		model.setCreateTime(new Date());
		System.out.println(model);
		feedBackService.saveOrUpdate(model);
		System.out.println(model);
		return SUCCESS;
	}
	
	//跳转处理页面
	@Action(value="feedBackAction_toHandle",results=@Result(name="toHandle",location="/WEB-INF/pages/home/feedback/jFeedBackHandle.jsp"))
	public String toHandle() throws Exception {
		FeedBack feedBack = feedBackService.get(model.getId());
		super.push(feedBack);
		
		return "toHandle";
	}
	//处理页面
	@Action(value="feedBackAction_handle",results=@Result(name="success",type="redirect",location="feedBackAction_myHandleList"))
	public String handle() throws Exception {
		FeedBack feedBack = feedBackService.get(model.getId());
		feedBack.setSolveMethod(model.getSolveMethod());
		feedBack.setAnswerTime(new Date());
		feedBack.setResolution(model.getResolution());
		feedBack.setDifficulty(model.getDifficulty());
		feedBack.setIsShare(model.getIsShare());
		feedBack.setState("1");
		feedBackService.saveOrUpdate(feedBack);
		
		return SUCCESS;
	}
	
	//删除页面
	@Action(value="feedBackAction_delete",results=@Result(name="success",type="redirect",location="feedBackAction_myList"))
	public String delete() throws Exception {
		String[] ids = model.getId().split(", ");
		feedBackService.delete(ids);
		return SUCCESS;
	}
	
	//系统反馈 属性驱动
	private String systemContext;
	
	public String getSystemContext() {
		return systemContext;
	}
	public void setSystemContext(String systemContext) {
		this.systemContext = systemContext;
	}
	//跳转系统反馈
	@Action(value="feedBackAction_tosystem" ,results=@Result(name="success",location="/WEB-INF/pages/home/feedback/jFeedBackToSystem.jsp"))
	public String tosystem() throws Exception {
		
		return SUCCESS;
	}
	
	//发送邮件
	@Action(value="feedBackAction_send",results=@Result(name="jump",type="redirect",location="memoAction_query"))
	public String send() throws Exception {
		MailUtil.sendMsg("rose@itheima.com", "系统反馈", systemContext);
		return "jump";
	}
	
	
}
