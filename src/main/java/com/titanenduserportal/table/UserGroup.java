package com.titanenduserportal.table;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "userGroup")
public class UserGroup implements java.io.Serializable {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "userGroupId", unique = true, nullable = false)
	private Integer userGroupId;

	@Column(name = "name", unique = true)
	private String name;

	@Column(name = "remark")
	private String remark;

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "userGroup_Role", joinColumns = { @JoinColumn(name = "userGroupId", referencedColumnName = "userGroupId") }, inverseJoinColumns = { @JoinColumn(name = "roleId", referencedColumnName = "roleId") })
	private Set<Role> roles = new HashSet<Role>();

	public UserGroup() {
	}

	public Integer getUserGroupId() {
		return this.userGroupId;
	}

	public void setDepartmentId(Integer userGroupId) {
		this.userGroupId = userGroupId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

}