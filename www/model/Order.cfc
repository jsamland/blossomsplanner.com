component persistent	= true
		  table			= 'Order'
		  output		= false
{
	// identifier
	property name="orderID" fieldtype="id" generator="identity" insert="false" update="false";

	// properties
	property name="OrderData" type="string" length="8000";
	
	property name="dateCreated" type="date" ormtype="timestamp";
	property name="dateModified" type="date" ormtype="timestamp";
	
	// relationships
	property name="form" fieldtype="many-to-one" CFC="Form" FKColumn="formID" lazy="true" ;
	property name="shop" fieldtype="many-to-one" CFC="Shop" FKColumn="shopID" lazy="true" ;
	
	//new functions
	
	public void function preInsert( any entity ){
		setDateCreated(now());
	}
	public void function preUpdate( any entity ){
		setDateModified(now());
	}
}