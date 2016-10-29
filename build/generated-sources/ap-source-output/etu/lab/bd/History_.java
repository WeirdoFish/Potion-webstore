package etu.lab.bd;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(History.class)
public abstract class History_ {

	public static volatile SingularAttribute<History, Integer> price;
	public static volatile SingularAttribute<History, Integer> purchase;
	public static volatile CollectionAttribute<History, Items> itemsCollection;
	public static volatile SingularAttribute<History, String> ship;
	public static volatile SingularAttribute<History, Date> time;
	public static volatile SingularAttribute<History, String> customer;

}

