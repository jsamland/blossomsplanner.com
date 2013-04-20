component persistent	= true
		  table			= 'Forms'
		  output		= false
{
	// identifier
	property name="formID" fieldtype="id" generator="identity" insert="false" update="false";

	// properties
	property name="formName" column="formName" type="string" length="100";
	property name="formDescription" column="formDescription" type="string" length="100";
	
	property name="dateCreated" type="date" ormtype="timestamp";
	property name="dateModified" type="date" ormtype="timestamp";
	
	// relationships
	property name="orders" singularname="order" fieldtype="one-to-many" CFC="Order" FKColumn="FormID" lazy="true" ;
	
	property name="shop" fieldtype="many-to-one" CFC="Shop" FKColumn="shopID" lazy="true" notnull="false" ;


	//new functions
	
	public void function preInsert( any entity ){
		setDateCreated(now());
	}
	public void function preUpdate( any entity ){
		setDateModified(now());
	}
}