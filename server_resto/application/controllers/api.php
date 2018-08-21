<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class api extends CI_Controller {



//ini api untuk ambil data yang di insert
	function ambilMakanan(){


		$hasil = $this->db->get("tb_menu");

		//check query ada datanya apa enggak
		if($hasil -> num_rows() > 0 ){

				//bikin response k mobile
			$data['pesan'] = "datanya ada";
			$data['sukses']  = true ;
			$data['data'] = $hasil->result();

		}
		else{
			$data['pesan'] = "datanya tidak ada";
			$data['sukses']  = false ;

		}
		echo json_encode($data);

	}


function updateMakanan(){

	$name = $this->input->post("name");
	$price = $this->input->post("price");
	$stok = $this->input->post("stok");
	$id = $this->input->post('id');


	$this->db->where('menu_id',$id);
	$getid = $this->db->get('tb_menu');

	if($getid -> num_rows() == 0 ){
	$data["sukses"] = false ;
	$data['pesan'] = 'produk belum ada';

			
	}else{


	$this->db->where('menu_id',$id);


	$update['menu_nama'] = $name ;
	$update['menu_harga'] = $price ; 
	$update['menu_stok'] = $stok ;

			$status = $this->db->update('tb_menu',$update) ;

		//	check insertnya berhasil apa enggak
	if($status){
		$data["sukses"] = true ;
		$data["pesan"] = "update berhasil";

	}
	else{
		$data["sukses"] = false ;
		$data["pesan"] = "update tidak  berhasil";

	}

}
echo json_encode($data);

}


//untuk ambil data menu berdasarkan dari id nya 
	function ambilDetailMakanan($id){



		$this->db->where('menu_id',$id);
		$hasil = $this->db->get("tb_menu");

		//check query ada datanya apa enggak
		if($hasil -> num_rows() > 0 ){

				//bikin response k mobile
			$data['pesan'] = "datanya ada";
			$data['sukses']  = true ;
			$data['data'] = $hasil->row();

		}
		else{
			$data['pesan'] = "datanya tidak ada";
			$data['sukses']  = false ;

		}
		echo json_encode($data);

	}


	function hapusMakanan($id){



		$this->db->where('menu_id',$id);
		$hasil = $this->db->delete("tb_menu");

		//check query ada datanya apa enggak
		if($hasil ){

				//bikin response k mobile
			$data['pesan'] = "berhasil hapus";
			$data['sukses']  = true ;
			

		}
		else{
			$data['pesan'] = "hapus tidak berhasil";
			$data['sukses']  = false ;

		}
		echo json_encode($data);

	}




function tambahMakanan(){


//variable untuk ambil inputan dari mobile
	$name = $this->input->post("name");
	$price = $this->input->post("price");
	$stok = $this->input->post("stok");


	//d implementasi nama field database nya
	$simpan = array();
	$simpan["menu_nama"] = $name ;
	$simpan["menu_harga"] = $price ;
	$simpan["menu_stok"] = $stok ;

	//using query for insert database
	$status = $this->db->insert("tb_menu",$simpan);

	$data = array();
//check insertnya berhasil apa enggak
	if($status){
		$data["sukses"] = true ;
		$data["pesan"] = "insert berhasil";

	}
	else{
		$data["sukses"] = false ;
		$data["pesan"] = "insert tidak  berhasil";

	}


echo json_encode($data);


}




}
