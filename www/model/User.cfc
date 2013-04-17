component persistent	= true
		  table			= 'Users'
		  output		= false
{
	// identifier
	property name="userID" fieldtype="id" generator="identity" insert="false" update="false";

	// properties
	property name="password" column="userPassword" type="string" length="100";
	property name="email" column="userEmail" type="string" length="100";
	property name="FName" column="FName" type="string" length="100";
	property name="LName" column="LName" type="string" length="100";
	
	property name="dateCreated" type="date" ormtype="timestamp";
	property name="dateModified" type="date" ormtype="timestamp";
	property name="resetCode" column="resetCode" type="string" length="50";
	
	// relationships
	property name="shops" fieldtype="many-to-many" CFC="Shop" linktable="ShopUsers" FKColumn="userID" inversejoincolumn="shopID" lazy="true" cascade="all" orderby="shopName";
	
	//new functions
	
	public void function preInsert( any entity ){
		setDateCreated(now());
	}
	public void function preUpdate( any entity ){
		setDateModified(now());
	}
}