// -*-c++-*-
/* $Id$ */

/*
 *
 * Copyright (C) 2005 Michael J. Freedman (mfreedman at alum.mit.edu)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 * USA
 *
 */

#ifndef _PRIVATE_MATCHING_H_
#define _PRIVATE_MATCHING_H_ 1

#include "vec.h"
#include "qhash.h"
#include "paillier.h"

struct cpayload {
  bigint ctxt; // ciphertext
  size_t ptsz; // plaintext size
};
struct ppayload {
  str    ptxt; // plaintext
};

class pm_client {
 private:
  ref<paillier_priv> sk;
  vec<bigint> coeffs;

  bool encrypt_polynomial (vec<bigint> &ccoeffs) const;

 public:
  pm_client (u_int nbits) 
    : sk (New refcounted<paillier_priv> (paillier_keygen (nbits))) {}
  pm_client (ref<paillier_priv> s) 
    : sk (s) {}

  bool set_polynomial (const vec<str> &roots);
  bool set_polynomial (const vec<bigint> &roots);
  const vec<bigint> & get_polynomial () const { return coeffs; }

  void decrypt_intersection (vec<str> &payloads, 
			     const vec<cpayload> &plds) const;
};


class pm_server {
 public:
  qhash<str, ppayload> inputs;
 private:
  void evaluate_polynomial (vec<cpayload> *res, 
			    const vec<bigint> *ccoeffs, 
			    const paillier_pub *pk,
			    const bigint *encone,
			    const str &x, ppayload *payload);
 public:
  pm_server () {}

  void evaluate_intersection (vec<cpayload> *res, 
			      const vec<bigint> *ccoeffs,
			      const paillier_pub *pk);
};


#endif /* _PRIVATE_MATCHING_H_ */