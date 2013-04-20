component persistent	= true
		  table			= 'Shops'
		  output		= false
{
	// identifier
	property name="shopID" fieldtype="id" generator="identity" insert="false" update="false";

	// properties
	property name="ShopName" type="string" length="100";
	
	property name="dateCreated" type="date" ormtype="timestamp";
	property name="dateModified" type="date" ormtype="timestamp";
	
	// relationships
	property name="users" fieldtype="many-to-many" CFC="User" linktable="ShopUsers" FKColumn="shopID" inversejoincolumn="userID" lazy="true" cascade="all";
	property name="orders" singularname="order" fieldtype="one-to-many" CFC="Order" FKColumn="shopID" lazy="true" ;

	//new functions
	
	public void function preInsert( any entity ){
		setDateCreated(now());
	}
	public void function preUpdate( any entity ){
		setDateModified(now());
	}
}