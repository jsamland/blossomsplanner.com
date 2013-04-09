<cfcomponent> 
	<cfscript>
    	public any function init(){
			return this;
		}
		remote boolean function deleteCategory(categoryID) roles="admin"{
			if( not isUserLoggedIn() or not isUserInRole("admin") )
				return false;
			
			var thisCat = entityLoadByPK("Category",arguments.categoryID);
			entityDelete(thisCat);
			
			return true;
		}
		remote boolean function deleteThread(threadID) roles="admin"{
			if( not isUserLoggedIn() or not isUserInRole("admin") )
				return false;
			
			var thisThread = entityLoadByPK("Thread",arguments.threadID);
			entityDelete(thisThread);
			
			return true;
		}
		remote boolean function deleteMessage(messageID) roles="admin"{
			if( not isUserLoggedIn() or not isUserInRole("admin") )
				return false;
			
			var thisMessage = entityLoadByPK("Message",arguments.messageID);
			entityDelete(thisMessage);
			
			return true;
		}
		remote boolean function deleteAttachment(attachmentID){
			var deleteThis=EntityLoadByPK("Attachment", arguments.attachmentID);
				
			if( deleteThis.getMessage().getUser().getUserId() eq getAuthUser() or listFindNoCase(getUserRoles(),'admin') ){
				//only allow attachment delete if the user made the message or are an admin
				deleteThis.setDeletedDate(now());
				deleteThis.setDeletedBy(EntityLoadByPK("User",GetAuthUser()));
				EntitySave(deleteThis);
				return true;
			}else{
				return false;
			}
		}
		remote boolean function setUserRole(userID, roleID) roles="admin"{
			if( not isUserLoggedIn() or not isUserInRole("admin") )
				return false;
			
			var thisRole = entityLoadByPK("Role",arguments.roleID);
			var thisUser = entityLoadByPK("User",arguments.userID);
			
			if( arrayFind(thisUser.getMyUserRoles(),thisRole) )
				thisUser.removeMyUserRoles(thisRole);
			else
				thisUser.addMyUserRoles(thisRole);
			
			return true;
		}
    </cfscript>
    
	<cffunction name="doLogin" >
		<cfargument name="userid" type="numeric"/>
	
		<cfset var logMeIn = EntityLoadByPK("User",arguments.userid) />
		<cfset session.User.ID=logMeIn.getUserID() />
		
		<cfset strRememberMe = (
			CreateUUID() & ":" &
			SESSION.User.ID & ":" &
			CreateUUID()
			) />
		<!--- Encrypt the value. --->
		<cfset strRememberMe = Encrypt(
			strRememberMe,
			APPLICATION.EncryptionKey,
			"cfmx_compat",
			"hex"
			) />
		<!--- Store the cookie such that it never expires. --->
		<cfcookie
			name="RememberMe"
			value="#strRememberMe#"
			expires="never"
			/>	
		<!---do the login--->	
		<cflogin>
			<cfloginuser name="#logMeIn.getUserID()#" password="#logMeIn.getUserPassword()#" roles="#logMeIn.getRoleList()#" />
		</cflogin>
		<cfreturn true />
	</cffunction>
    
	<cffunction name="checkLogin" >
		<cfargument name="username"/>
		<cfargument name="password"/>
		
		<!---<cfset var logMeIn = entityload("User",{userName=arguments.userName,userPassword=arguments.password},"true") />--->
		<cfset var logMeIn = ormExecuteQuery("from User where (userName='#arguments.userName#' or userEmail='#arguments.userName#') and userPassword='#arguments.password#'","true") />

		<cfif isDefined("logMeIn")>
			<cfset doLogin(logMeIn.getUserID()) />
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
    
	<cffunction name="doLogout">
		<cfcookie
			name="RememberMe"
			value=""
			expires="now"
			/>	
		<cflogout />
	</cffunction>

	<cffunction name="categorySearch" access="remote" returnformat="plain" >
		<cfargument name="searchString"/>
		<cfargument name="categoryID"/>
		
		<cfset var currCat=entityLoadByPK("Category",arguments.categoryID)/>
		<cfset var results=ormExecuteQuery("from Category where CategoryText like '%#arguments.searchString#%'")/>
		<cfset var return=""/>
		
		<cfsavecontent variable="return" >
			<cfoutput>
				<cfif not currCat.hasParentCategory()>
	            	<label><input type="radio" name="newParentCategoryID" value="" checked="checked"> Forums Top</label><br/>
				<cfelse>
	            	<label><input type="radio" name="newParentCategoryID" value=""> Forums Top</label><br/>
					<label><input type="radio" name="newParentCategoryID" value="#currCat.getParentCategory().getCategoryID()#" checked="checked">> #currCat.getParentCategory().getParentLinks(false)#</label><br/>
				</cfif>
				<cfloop array="#results#" index="cat" >
					<!--- cannot be a child of itself --->
					<cfif cat.getCategoryID() eq currCat.getCategoryID()><cfcontinue/></cfif>
					<label><input type="radio" name="newParentCategoryID" value="#cat.getCategoryID()#"> #cat.getParentLinks(false)#</label><br/>
				</cfloop>
				<input type="submit" name="moveCategory" value="Move category" />
            </cfoutput>
		</cfsavecontent>
		
		<cfreturn return/>
	</cffunction>
    
	<cffunction name="ImageWriteToBrowserCustom"
		returntype="void"
		output="true"
		hint="Writes the image to the browser with additional attributes.">
	 
		<!--- Define arguments. --->
		<cfargument name="Image" type="any" required="true"
			hint="The ColdFusion image object that you are writing to browser." />
	 
		<cfargument name="Alt" type="string" required="false" default=""
			hint="The ALT attribute value to apply to the image." />
	 
		<cfargument name="Class" type="string" required="false" default=""
			hint="The CSS class to apply to the image." />
	 
		<cfargument name="Style" type="string" required="false" default=""
			hint="The STYLE attribute value to apply to the image." />
	 
		<cfargument name="Height" type="string" required="false" default=""
			hint="The HEIGHT attribute value to apply to the image." />
	 
		<cfargument name="Width" type="string" required="false" default=""
			hint="The WIDTH attribute value to apply to the image." />
	 
		<cfargument name="Border" type="string" required="false" default=""
			hint="The BORDER attribute value to apply to the image." />
	 
		<cfargument name="margin" type="string" required="false" default=""
			hint="The MARGIN attribute value to apply to the image." />
	 
		<cfargument name="Clickable" type="boolean" required="false" default="false"
			hint="Clicking the image opens a window" />
	 
		<!--- Define the local scope. --->
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.myImage = ImageNew(ARGUMENTS.Image)>
		
		<cfif arguments.width neq "" and LOCAL.myImage.getWidth() gt arguments.width>
			<cfset ImageResize(LOCAL.myImage, arguments.width, "")>
		</cfif>
		<cfif arguments.height neq "" and LOCAL.myImage.getHeight() gt arguments.height>
			<cfset ImageResize(LOCAL.myImage, "", arguments.height)>
		</cfif>
		<cfif arguments.Border neq "">
			<cfset ImageAddBorder(LOCAL.myImage, arguments.border)>
		</cfif>
		
		<!---
			Write the image to the browser. This is really just
			creating the image and then writing to the buffer.
			All we have to do is intercept the buffer write.
		--->
		<cfsavecontent variable="LOCAL.Output">
			<cfoutput>
	 
				<!--- Write image tag. --->
				<cfimage
					action="writetobrowser"
					source="#LOCAL.myImage#" 
					format="jpg"
					/>
	 
			</cfoutput>
		</cfsavecontent>
	 
		<!---
			First, delete any existing attributes that we might
			be using (so that we can just add new ones).
		--->
		<cfset LOCAL.Output = LOCAL.Output.ReplaceAll(
			"(?i) (alt|class|style|height|width|border)=""[^""]*""",
			""
			) />
	 
		<!---
			Now that we have an image with Just the SRC
			attribute, we can go about adding our attributes.
			First, chop off the trailing slash.
		--->
		<cfset LOCAL.Output = LOCAL.Output.ReplaceFirst(
			"\s*/?>\s*$",
			""
			) />
	 
		<!---
			Loop over the arguments to see if we need to
			add them to the tag.
		--->
		<cfloop
			index="LOCAL.Key"
			list="alt,class,style"
			delimiters=",">
	 
			<!--- Check for a passed-in value. --->
			<cfif Len( ARGUMENTS[ LOCAL.Key ] )>
	 
				<!---
					Append this argument to the output and a
					key-value attribute.
				--->
				<cfset LOCAL.Output &= (
					" " &
					LOCAL.Key &
					"=""" &
					ARGUMENTS[ LOCAL.Key ] &
					""""
					) />
	 
			</cfif>
	 
		</cfloop>
		
		<!--- Write the image tag to the output. --->
		<cfset WriteOutput( LOCAL.Output & " />" ) />
	 
		<!--- Return out. --->
		<cfreturn />
	</cffunction>

</cfcomponent>